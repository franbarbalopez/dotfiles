if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source "$ZSH/oh-my-zsh.sh"

source "$OMARCHY_PATH/default/bash/envs"
source "$OMARCHY_PATH/default/bash/aliases"
eval "$(mise activate zsh)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)
[[ -r ~/.p10k.zsh ]] && source ~/.p10k.zsh
# Machine-specific settings stay outside this repository.
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
