#!/usr/bin/env bash
set -euo pipefail
repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

if ! command -v omarchy >/dev/null; then
  echo "This installer requires Omarchy." >&2
  exit 1
fi

for component in applications terminals development themes fonts shell github; do
  bash "$repo_dir/$component/install.sh"
done

printf '\nSetup complete. Log out and back in, then open a terminal.\n'
