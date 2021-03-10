#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

while read theme; do
    echo $theme > ~/.theme
    echo "$(date): $theme";

    echo -n "Updating emacs theme..."
    /Users/matt/.nix-profile/bin/emacsclient -f ~/.emacs.d/server/server -e "(update-ui-appearance \"${theme}\")" && echo "ok" || echo "failed"

    echo -n "Updating terminal default theme..."
    osascript -e "tell application \"Terminal\"" -e "set default settings to settings set \"Terminal ${theme}\"" -e "end tell" && echo "ok" || echo "failed"
    echo -n "Updating existing terminal themes..."
    osascript -e "tell application \"Terminal\"" -e "set current settings of tabs of windows to settings set \"Terminal ${theme}\"" -e "end tell" && echo "ok" || echo "failed"
done < <(/usr/bin/swift ./auto-dark-mode.swift)
