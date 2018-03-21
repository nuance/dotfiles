"""Concatenate emacs configs.

$ python concat_emacs_config.py $(ls emacs emacs_includes/*.el | sort) > emacs.concat.el
"""

import sys

MARKER = '=== CONCAT ==='

if __name__ == '__main__':
    base_file = sys.argv[1]
    extensions = sys.argv[2:]

    with open(base_file) as base:
        for line in base:
            if MARKER in line:
                break
            print(line.rstrip())

    for filename in extensions:
        with open(filename) as file:
            print(";; INCLUDED FROM " + filename)
            print(file.read() + "\n")
