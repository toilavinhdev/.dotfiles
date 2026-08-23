# Dotfiles

Dotfiles repo managed by GNU Stow.

## Prerequisites

Install GNU Stow:

```bash
# Ubuntu/Debian
sudo apt install stow -y

# Fedora
sudo dnf install stow -y
```

## Structure

```
.
├── tmux/.tmux.conf
├── nvim/.config/nvim/    (coming soon)
└── git/.gitconfig         (coming soon)
```

Each top-level directory is a stow package. The directory structure mirrors `$HOME`.

## Usage

```bash
# Symlink all packages
stow */

# Symlink a specific package
stow tmux

# Unsymlink
stow -D tmux
```

## Conventions

- One directory per tool/package
- Use `.config/` for XDG-compliant tools
- Keep configs minimal and portable
- Test before committing
