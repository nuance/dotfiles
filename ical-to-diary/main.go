package main

import (
	"bufio"
	"flag"
	"fmt"
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
	urlRegexes   = flag.String("regexes", "dotfiles/ical-to-diary/urls.txt", "file containing url extraction regexes, one per line")
	extraRegexes   = flag.String("extra", "dotfiles/ical-to-diary/extra.txt", "file containing extra extraction regexes, one per line")
)

type entry struct {
	Start, End  time.Time
	Description string
	URL         *url.URL
	People      int
	Extra string
}

func (e *entry) String() string {
	b := new(strings.Builder)

	if err := diaryTemplate.Execute(b, e); err != nil {
		panic(err)
	}

	return b.String()
}

var diaryTemplate = template.Must(template.New("diary").Parse(`{{.Start.Format "01/02/06 15:04"}}-{{.End.Format "15:04"}} {{.Description}}{{if lt .People 2}}{{else if eq .People 2}} (1:1){{else if lt .People 10}} ({{.People}} attendees){{else if gt .People 9}} (10+ attendees){{end}}{{if .URL}} - {{.URL}}{{end}}{{ if .Extra }} - {{.Extra}}{{ end }}
`))

var (
	urlMatchers []*regexp.Regexp
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
		log.Fatalf("error opening url regex file: %w", err)
	} else {
		defer rf.Close()
		sc := bufio.NewScanner(rf)
		for sc.Scan() {
			urlMatchers = append(urlMatchers, regexp.MustCompile(sc.Text()))
		}
	}

	if rf, err := os.Open(*extraRegexes); err != nil {
		log.Fatalf("error opening extra regex file: %w", err)
	} else {
		defer rf.Close()
		sc := bufio.NewScanner(rf)
		for sc.Scan() {
			extraMatchers = append(extraMatchers, regexp.MustCompile(sc.Text()))
		}
	}

	var diary []entry
	seen := map[string]bool{}

	if err := filepath.Walk(*calendarPath, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return fmt.Errorf("%s: %w", path, err)
		}

		if !strings.HasSuffix(path, "ics") {
			return nil
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
			if ev.Start == nil || ev.End == nil {
				return nil
			}

			var people []string
			if ev.Organizer != nil {
				people = append(people, ev.Organizer.Cn)
			}

			for _, at := range ev.Attendees {
				people = append(people, at.Cn)
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

			ent := entry{
				Start:       *ev.Start,
				End:         *ev.End,
				Description: ev.Summary,
				People:      len(people),
				URL:         url,
				Extra: strings.Join(extraParts, " / "),
			}

			if seen[ev.Uid + ev.RecurrenceID] || seen[ent.String()] {
				continue
			}

			seen[ev.Uid + ev.RecurrenceID] = true
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

	df, err := os.Create(*diaryOutput)
	if err != nil {
		log.Fatalln("error creating diary output", err)
	}
	defer df.Close()

	for _, entry := range diary {
		if err := diaryTemplate.Execute(df, entry); err != nil {
			log.Fatalln("error building diary entry", err)
		}
	}
}
