#!/usr/bin/env bash
set -euo pipefail
repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

if command -v omarchy >/dev/null; then
  omarchy pkg add zsh
else
  sudo pacman -S --needed zsh
fi

clone() {
  [[ -d "$2" ]] || git clone --depth=1 "$1" "$2"
}

clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
clone https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"

for target in .zshenv .zshrc .p10k.zsh; do
  cp --remove-destination "$repo_dir/shell/$target" "$HOME/$target"
done

[[ ${SHELL:-} == /usr/bin/zsh ]] || chsh -s /usr/bin/zsh

printf '\nSetup complete. Log out and back in, then open a terminal.\n'
