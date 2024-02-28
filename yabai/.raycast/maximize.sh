#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Yabai: Maximize
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

app_name=$((yabai -m query --windows --window 2> /dev/null || echo "{\"app\": \"\"}" ) | jq .app)

if [ "$app_name" == '""' ] || [ "$app_name" == '"Emacs"' ]; then
    /opt/homebrew/bin/emacsclient -e "(toggle-frame-fullscreen)" > /dev/null 2>&1
else
    yabai -m window --toggle zoom-fullscreen
fi
