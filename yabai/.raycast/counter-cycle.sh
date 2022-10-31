#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Yabai: Counter-Cycle
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

#!/bin/bash

win=$(yabai -m query --windows --window first | jq '.id')

while : ; do
    yabai -m window $win --swap next &> /dev/null
    if [[ $? -eq 1 ]]; then
        break
    fi
done
