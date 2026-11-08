# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Prerequisites

```bash
# Ubuntu/Debian
sudo apt install stow zsh tmux git -y

# Fedora
sudo dnf install stow zsh tmux git -y
```

## Structure

```
.
├── git/.config/git/config              # Git config and aliases
├── lazydocker/.config/lazydocker/      # Lazydocker config
├── tmux/.config/tmux/tmux.conf         # Tmux config (TPM plugins)
├── vscode/
│   ├── .config/Code/User/settings.json # VS Code settings
│   └── extensions/                     # Extension import/export scripts
├── zsh/                                # Zsh config (see zsh/README.md)
└── .fonts/                             # JetBrainsMono Nerd Font (not stowed)
```

Each top-level directory is a stow package. Its contents mirror `$HOME`, so
`git/.config/git/config` is linked to `~/.config/git/config`.

## Usage

```bash
# Symlink all packages
stow -v */

# Symlink a specific package
stow -v zsh

# Remove symlinks
stow -D zsh

# Re-link after adding files
stow -v -R zsh
```

`.fonts/` is kept in the repo for reference but is not a stow package.

## Packages

| Package | Description |
|---------|-------------|
| `git` | Git config with sane defaults and aliases |
| `lazydocker` | Lazydocker TUI config |
| `tmux` | Tmux config with TPM, resurrect and a custom status bar |
| `vscode` | VS Code settings and extension scripts |
| `zsh` | Zsh, Oh My Zsh and custom theme/functions (see [zsh/README.md](zsh/README.md)) |

## Conventions

- One directory per tool/package
- Use `.config/` for XDG-compliant tools
- Keep configs minimal and portable
- Commit one package per commit using `type(scope): subject`
- Test before committing
