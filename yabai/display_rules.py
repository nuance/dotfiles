#!/usr/bin/env python3

import json
import os
import subprocess

if __name__ == '__main__':
    displays = json.loads(subprocess.check_output(["/opt/homebrew/bin/yabai", "-m", "query", "--displays"]))

    changes = []
    for display in displays:
        spaces = json.loads(subprocess.check_output(["/opt/homebrew/bin/yabai", "-m", "query", "--spaces"]))
        display_spaces = [space for space in spaces if space['display'] == display['index']]

        layout = 'bsp' if display['frame']['w'] > 1800 else 'stack'
        changes.append(f"{display['id']}: {layout} {[space['id'] for space in display_spaces]}")
        for space in display_spaces:
            subprocess.check_call(["/opt/homebrew/bin/yabai", "-m", "space", f"{space['index']}", "--layout", layout])

    # change_string = "\n".join(changes)
    # subprocess.check_call(["/usr/bin/osascript", "-e", f"display notification \"{change_string}\" with title \"Yabai Layout\""])
