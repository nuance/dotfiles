#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Yabai: Focus Next
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

yabai -m window --focus next &> /dev/null || yabai -m window --focus first
