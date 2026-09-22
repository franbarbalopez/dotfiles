#!/usr/bin/env bash
set -euo pipefail

if ! omarchy pkg present kitty || [[ ! -d "$HOME/.config/kitty" ]]; then
  omarchy install terminal kitty
elif [[ $(omarchy default terminal) != kitty ]]; then
  omarchy default terminal kitty
fi
