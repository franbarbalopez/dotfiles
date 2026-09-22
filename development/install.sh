#!/usr/bin/env bash
set -euo pipefail

if ! omarchy pkg present php composer php-sqlite xdebug ||
   [[ ! -x "$HOME/.config/composer/vendor/bin/laravel" ]] ||
   ! mise which node >/dev/null 2>&1; then
  omarchy install dev-env laravel
fi
