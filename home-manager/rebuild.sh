#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

nix-shell -p nixUnstable --command "nix build --show-trace --verbose --experimental-features 'nix-command flakes' './#homeConfigurations.${1}.activationPackage'"
result/activate
rm result
