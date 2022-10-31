#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Yabai: Focus Previous
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

yabai -m window --focus prev || yabai -m window --focus last_node
