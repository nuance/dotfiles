#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

git add .
git commit -am "snapshot"
git push