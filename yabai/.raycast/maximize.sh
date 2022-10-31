#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Yabai: Maximize
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

app_name=$(yabai -m query --windows --window | jq .app || echo)

if [ "$app_name" == "" ] || [ "$app_name" == '"Emacs"' ]; then
    /Applications/Emacs.app/Contents/MacOS/bin/emacsclient -e "(toggle-frame-fullscreen)" > /dev/null 2>&1
else
    yabai -m window --toggle zoom-fullscreen
fi
