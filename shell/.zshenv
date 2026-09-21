# Keep Omarchy's environment when installed; remain portable elsewhere.
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap
typeset -U path
path=("$HOME/.local/bin" "$HOME/.config/composer/vendor/bin" $path)
export PATH
