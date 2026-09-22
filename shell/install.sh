#!/usr/bin/env bash
set -euo pipefail
shell_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

omarchy pkg add zsh

clone() {
  [[ -d "$2" ]] || git clone --depth=1 "$1" "$2"
}

clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
clone https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"

for target in .zshenv .zshrc .p10k.zsh; do
  if ! cmp -s "$shell_dir/$target" "$HOME/$target"; then
    cp --remove-destination "$shell_dir/$target" "$HOME/$target"
  fi
done

if [[ $(getent passwd "$(id -un)" | cut -d: -f7) != /usr/bin/zsh ]]; then
  chsh -s /usr/bin/zsh
fi
