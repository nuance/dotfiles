#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

nix-shell -p nixUnstable --command "nix build --show-trace --verbose --experimental-features 'nix-command flakes' './#$1'"
result/activate
rm result
