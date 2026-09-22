# Omarchy dotfiles

Personal setup for **Omarchy**.

## Install

```sh
git clone https://github.com/franbarbalopez/dotfiles
cd dotfiles
./install.sh
```

Log out and back in afterward.

## Components

The root installer runs these in order:

| Folder | Setup |
| --- | --- |
| `applications/` | AUR: `slack-desktop`, `github-desktop-bin`, `claude-desktop`. Omarchy installers: ChatGPT, Zed with theme integration, Google Chrome. |
| `terminals/` | Kitty as the default terminal. |
| `development/` | Laravel via Omarchy: PHP, Composer, extensions, Xdebug, Node.js through mise, and Laravel installer. |
| `themes/` | Matte Black. |
| `fonts/` | `otf-geist-mono-nerd`; selects `GeistMono Nerd Font` for terminals and system monospace. |
| `shell/` | Zsh as login shell, Oh My Zsh, autosuggestions, syntax highlighting, Powerlevel10k; loads Omarchy environment/aliases, mise, zoxide, fzf, and Composer's executable path. |
| `github/` | GitHub authentication, SSH key registration, SSH Git operations, and automatic commit signing. |

To install one component: `bash <folder>/install.sh`
