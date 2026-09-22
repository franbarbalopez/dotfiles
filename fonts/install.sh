#!/usr/bin/env bash
set -euo pipefail

omarchy pkg add otf-geist-mono-nerd
if [[ $(omarchy font current) != "GeistMono Nerd Font" ]] ||
   { [[ -f "$HOME/.config/kitty/kitty.conf" ]] && ! grep -Eq '^font_family[[:space:]]+GeistMono Nerd Font[[:space:]]*$' "$HOME/.config/kitty/kitty.conf"; }; then
  omarchy font set "GeistMono Nerd Font"
fi
