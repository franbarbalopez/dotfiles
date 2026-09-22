#!/usr/bin/env bash
set -euo pipefail

if [[ $(omarchy theme current) != "Matte Black" ]]; then
  omarchy theme set "Matte Black"
fi
