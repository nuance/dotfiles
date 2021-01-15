# ical-to-diary

I try to keep my life organized via emacs, but don't always want to deal with emacs' mediocre integrations. For calendarying, Calendar.app is pretty good at working with exchange / gcal / whatever, and happens to dump all the resulting events into ical files in `~/Library/Calendars`. Rather than parse these via emacs/elisp (which is excrutiatingly slow), I wrote a simple go program to crawls and summarize these calendars and write the result into my emacs diary.

I have this set up to run every minute via cron.

## Building

Either run `go build` in this directory, or pull in the nix expression defined in `default.nix` (which I do via home-manager).

## Configuration

There are three interesting configuration options:

`-timezone [America/New_York]` - pass a timezone parseable via the go `time.LoadLocation` function; eg a IANA Time Zone database entry.

`-urlRegexes [path]` - pass a path to a file containing one regex per line. For every ical entry, the first regex to find a substring in the description will be pulled out. I use this to find zoom or bluejeans links inside descriptions, which will then be shown in the diary entry for quick launching.

`-extraRegexes [path]` - pass a path to a file containing one regex per line. Every regex will be run on the description of each event, and the results will be concatenated into the resulting diary description. I use these to pull out zoom meeting codes or other useful structured-ish metadata that shows up in my events.
