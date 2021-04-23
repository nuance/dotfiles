package main

import (
	"bufio"
	"bytes"
	"flag"
	"fmt"
	"hash/crc64"
	"io"
	"log"
	"net/url"
	"os"
	"path/filepath"
	"regexp"
	"strings"
	"text/template"
	"time"

	"github.com/apognu/gocal"
)

var (
	calendarPath = flag.String("calendars", "Library/Calendars", "Path prefix for ical files")
	diaryOutput  = flag.String("diary", ".emacs.d/diary", "Emacs diary path")
	urlRegexes   = flag.String("regexes", ".ical-to-diary/urls.txt", "file containing url extraction regexes, one per line")
	extraRegexes = flag.String("extra", ".ical-to-diary/extra.txt", "file containing extra extraction regexes, one per line")
	timezone     = flag.String("timezone", "America/New_York", "time zone to load")
	dateRange    = flag.Duration("daterange", 30*24*time.Hour, "period to filter on")
	debug        = flag.Bool("debug", false, "write debug information to the console")
)

type entry struct {
	Start, End  time.Time
	Description string
	URL         *url.URL
	People      int
	Extra       string
	Details     string
}

func (e *entry) String() string {
	b := new(strings.Builder)

	if err := diaryTemplate.Execute(b, e); err != nil {
		panic(err)
	}

	return b.String()
}

var diaryTemplate = template.Must(template.New("diary").Parse(`{{.Start.Format "01/02/06 15:04"}}-{{.End.Format "15:04"}} {{.Description}}{{if lt .People 2}}{{else if eq .People 2}} (1:1){{else if lt .People 10}} ({{.People}} attendees){{else if gt .People 9}} (10+ attendees){{end}}{{if .URL}} - {{.URL}}{{end}}{{ if .Extra }} - {{.Extra}}{{ end }}{{.Details}}
`))

var (
	urlMatchers   []*regexp.Regexp
	extraMatchers []*regexp.Regexp
)

func bestURL(description string) (*url.URL, error) {
	for _, matcher := range urlMatchers {
		if s := matcher.FindString(description); len(s) > 0 {
			return url.Parse(s)
		}
	}

	return nil, nil
}

func main() {
	flag.Parse()

	if rf, err := os.Open(*urlRegexes); err != nil {
		log.Fatalf("error opening url regex file: %s", err)
	} else {
		defer rf.Close()
		sc := bufio.NewScanner(rf)
		for sc.Scan() {
			urlMatchers = append(urlMatchers, regexp.MustCompile(sc.Text()))
		}
	}

	if rf, err := os.Open(*extraRegexes); err != nil {
		log.Fatalf("error opening extra regex file: %s", err)
	} else {
		defer rf.Close()
		sc := bufio.NewScanner(rf)
		for sc.Scan() {
			extraMatchers = append(extraMatchers, regexp.MustCompile(sc.Text()))
		}
	}

	loc, err := time.LoadLocation(*timezone)
	if err != nil {
		log.Fatalf("couldn't load local timezone: %s", err)
	}

	startCutoff := time.Now().In(loc).Add(-*dateRange)
	endCutoff := time.Now().In(loc).Add(*dateRange)

	var diary []entry
	seen := map[string]bool{}

	if err := filepath.Walk(*calendarPath, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return fmt.Errorf("%s: %w", path, err)
		}

		if !strings.HasSuffix(path, "ics") {
			return nil
		}

		if *debug {
			log.Printf("Reading from %s", path)
		}

		f, err := os.Open(path)
		if err != nil {
			return fmt.Errorf("error opening %s: %w", path, err)
		}
		defer f.Close()

		c := gocal.NewParser(f)
		c.SkipBounds = true
		c.Parse()

		for _, ev := range c.Events {
			if *debug {
				log.Println("Processing", ev)
			}

			if ev.Start == nil || ev.End == nil {
				return nil
			}

			if ev.Start.In(loc).Before(startCutoff) || ev.End.In(loc).After(endCutoff) {
				return nil
			}

			people := map[string]bool{}
			if ev.Organizer != nil {
				people[ev.Organizer.Cn] = true
			}

			for _, at := range ev.Attendees {
				people[at.Cn] = true
			}

			url, err := bestURL(ev.Description)
			if err != nil {
				return fmt.Errorf("error finding best url: %w", err)
			}

			var extraParts []string
			for _, matcher := range extraMatchers {
				if s := matcher.FindString(ev.Description); len(s) > 0 {
					extraParts = append(extraParts, s)
				}
			}

			splitDetails := strings.ReplaceAll(strings.ReplaceAll(ev.Description, "\\n", "\n"), "<br>", "\n")

			details := []string{"\n"}
			for _, s := range strings.Split(splitDetails, "\n") {
				details = append(details, "# "+s)
			}

			if len(details) > 1 {
				details = append(details, "\n")
			} else {
				details = nil
			}

			ent := entry{
				Start:       ev.Start.In(loc),
				End:         ev.End.In(loc),
				Description: ev.Summary,
				People:      len(people),
				URL:         url,
				Extra:       strings.Join(extraParts, " / "),
				Details:     strings.Join(details, "\n"),
			}

			if seen[ev.Uid+ev.RecurrenceID] || seen[ent.String()] {
				continue
			}

			seen[ev.Uid+ev.RecurrenceID] = true
			seen[ent.String()] = true
			diary = append(diary, ent)
		}

		return nil
	}); err != nil {
		log.Fatalln("error reading calendars", err)
	}

	if len(diary) == 0 {
		return
	}

	outBuf := bytes.NewBuffer(nil)
	for _, entry := range diary {
		if err := diaryTemplate.Execute(outBuf, entry); err != nil {
			log.Fatalln("error building diary entry", err)
		}
	}

	crc := crc64.New(crc64.MakeTable(crc64.ISO))
	if _, err := io.Copy(crc, bytes.NewReader(outBuf.Bytes())); err != nil {
		log.Fatalln("error checksumming new output", err)
	}
	newChecksum := crc.Sum64()

	existingChecksum := func() uint64 {
		if f, err := os.Open(*diaryOutput); err == nil {
			defer f.Close()

			crc.Reset()
			if _, err := io.Copy(crc, f); err != nil {
				log.Fatalln("error checksumming new output", err)
			}
			return crc.Sum64()
		}

		return 0
	}()

	if newChecksum == existingChecksum {
		return
	}

	df, err := os.Create(*diaryOutput)
	if err != nil {
		log.Fatalln("error creating diary output", err)
	}
	defer df.Close()

	if _, err := io.Copy(df, outBuf); err != nil {
		log.Fatalln("error writing to diary", err)
	}
}
