#!/usr/bin/env bash
set -euo pipefail

if ! gh auth status --hostname github.com >/dev/null 2>&1; then
  gh auth login --hostname github.com --git-protocol ssh --web --skip-ssh-key \
    --scopes admin:public_key,admin:ssh_signing_key
else
  gh auth refresh --hostname github.com --scopes admin:public_key,admin:ssh_signing_key
fi

for field in name email; do
  if [[ -z $(git config --global --get "user.$field" || true) ]]; then
    read -r -p "Git $field (use a verified GitHub email for signing): " value
    [[ -n $value ]] || { echo "Git $field is required." >&2; exit 1; }
    git config --global "user.$field" "$value"
  fi
done

# Reuse an existing identity from the effective GitHub SSH configuration.
key=""
while read -r option identity; do
  [[ $option == identityfile ]] || continue
  identity=${identity/#\~/$HOME}
  if [[ -f $identity ]]; then
    key=$identity
    break
  fi
done < <(ssh -G git@github.com 2>/dev/null)

if [[ -z $key ]]; then
  key="$HOME/.ssh/id_ed25519"
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
  # Refuse to replace an orphaned public key or a dangling symlink.
  if [[ -e $key || -L $key || -e $key.pub || -L $key.pub ]]; then
    echo "Existing key files at $key need attention; refusing to overwrite them." >&2
    exit 1
  fi
  ssh-keygen -t ed25519 -C "$(git config --global user.email)" -f "$key"
fi

# Derive the public key, including when its .pub file is missing or stale.
public_key=$(ssh-keygen -y -f "$key" | awk '{print $1 " " $2}')
public_file=$(mktemp)
trap 'rm -f "$public_file"' EXIT
printf '%s\n' "$public_key" > "$public_file"

for type in authentication signing; do
  endpoint=user/keys
  [[ $type == signing ]] && endpoint=user/ssh_signing_keys
  registered=$(gh api --hostname github.com --paginate "$endpoint" --jq '.[].key')
  if ! awk '{print $1 " " $2}' <<< "$registered" | grep -Fxq -- "$public_key"; then
    GH_HOST=github.com gh ssh-key add "$public_file" --type "$type" --title "$(hostname)"
  fi
done

gh config set git_protocol ssh --host github.com
# Also use SSH for existing HTTPS GitHub remotes, without editing each repo.
git config --global url."git@github.com:".insteadOf https://github.com/
git config --global gpg.format ssh
git config --global user.signingkey "$key"
git config --global commit.gpgsign true

printf '\nGitHub SSH access and commit signing configured.\n'
printf 'For a passphrase-protected key, load it into your session agent with: ssh-add %q\n' "$key"
