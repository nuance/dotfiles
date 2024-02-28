#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Yabai: Layout
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

case $(yabai -m query --spaces --space | jq -r .type) in
    bsp)
        yabai -m space --layout stack
        echo "stack"
    ;;

    stack)
        yabai -m space --layout float
        echo "float"
    ;;

    float)
        yabai -m space --layout bsp
        echo "tile"
    ;;
esac
