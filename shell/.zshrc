if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source "$ZSH/oh-my-zsh.sh"

if [[ -n ${OMARCHY_PATH:-} ]]; then
  [[ -r "$OMARCHY_PATH/default/bash/envs" ]] && source "$OMARCHY_PATH/default/bash/envs"
  [[ -r "$OMARCHY_PATH/default/bash/aliases" ]] && source "$OMARCHY_PATH/default/bash/aliases"
fi
(( $+commands[mise] )) && eval "$(mise activate zsh)"
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
if (( $+commands[fzf] )); then
  # --zsh requires fzf 0.48+. Older distribution packages use separate scripts.
  if fzf --help 2>/dev/null | command grep -q -- '--zsh'; then
    source <(fzf --zsh)
  else
    for script in /usr/share/fzf/key-bindings.zsh /usr/share/doc/fzf/examples/key-bindings.zsh; do
      [[ -r $script ]] && { source "$script"; break; }
    done
  fi
fi
[[ -r ~/.p10k.zsh ]] && source ~/.p10k.zsh
# Machine-specific settings stay outside this repository.
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
