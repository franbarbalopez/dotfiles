#!/usr/bin/env bash
set -euo pipefail

omarchy pkg aur add slack-desktop github-desktop-bin claude-desktop
if ! omarchy pkg present openai-codex-desktop; then
  omarchy install ai chatgpt
fi
if ! omarchy pkg present zed omazed || [[ ! -f "$HOME/.config/zed/themes/omazed.json" ]]; then
  omarchy install editor zed
fi
if ! omarchy pkg present google-chrome || [[ ! -f "$HOME/.config/chrome-flags.conf" ]]; then
  omarchy install browser chrome
fi
