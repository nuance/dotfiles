#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

MACHINE=$1;
shift;

nix-build --cores 0 '<nixos/nixos>' -I nixos-config=$MACHINE -A config.system.build.sdImage --no-out-link
