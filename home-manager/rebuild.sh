#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

nix build --show-trace --verbose "./#homeConfigurations.${1}.activationPackage"
result/activate
rm result
