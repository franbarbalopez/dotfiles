# Load Omarchy's environment for every Zsh session.
source /usr/share/omarchy/default/bash/env-bootstrap
typeset -U path
path=("$HOME/.local/bin" "$HOME/.config/composer/vendor/bin" $path)
export PATH
