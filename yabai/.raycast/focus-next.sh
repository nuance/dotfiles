#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Yabai: Focus next
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

yabai -m window --focus next || yabai -m window --focus first_node
