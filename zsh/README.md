# Zsh Configuration

## Install

### 1. Zsh

```bash
sudo apt-get install zsh
```

### 2. Set default shell

```bash
chsh -s "$(which zsh)"
```

Log out and back in for the change to take effect.

### 3. Symlink the package

```bash
stow -v zsh
```

`~/.zshenv` sets `ZDOTDIR=~/.config/zsh`, so every other file is read from
there instead of `$HOME`.

### 4. Oh My Zsh

```bash
ZSH="$HOME/.config/.oh-my-zsh" sh -c "$(curl -fsSL https://install.ohmyz.sh/)"
```

### 5. Plugins

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions \
  "$ZSH/custom/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  "$ZSH/custom/plugins/zsh-syntax-highlighting"
```

### 6. Reload configuration

```bash
source ~/.zshenv
# or, from an interactive shell
reload
```

## File Overview

| File | Description |
|------|-------------|
| `.zshenv` | Exports `ZDOTDIR`; loaded for all shell types |
| `.zshrc` | Interactive shell entrypoint: loads `conf.d/` then `func.d/`, prints the startup banner |
| `.zprofile` | Optional login-shell config (copy from `.zprofile.example`) |
| `conf.d/*.zsh` | Environment, aliases and Oh My Zsh setup |
| `func.d/*.zsh` | Custom shell functions |

## Load Order

```
.zshenv → .zprofile → .zshrc → conf.d/*.zsh → func.d/*.zsh → (session ends) → .zlogout
```

## Structure

```
~/.dotfiles/zsh/
├── .zshenv                          # Sets ZDOTDIR to ~/.config/zsh
└── .config/
    ├── .oh-my-zsh/themes/           # Custom theme (toilavinhdev)
    └── zsh/
        ├── .zshrc                   # Interactive shell entrypoint
        ├── .zprofile.example        # Example login-shell config
        ├── conf.d/
        │   ├── env.zsh              # PATH, history, nvm
        │   ├── alias.zsh            # Shell aliases
        │   └── ohmyzsh.zsh          # Oh My Zsh theme and plugins
        └── func.d/
            ├── file.zsh             # File helpers
            ├── network.zsh          # Network helpers
            └── index.zsh            # Utilities
```

Every `*.zsh` file in `conf.d/` and `func.d/` is sourced automatically, so a
new module only needs to be dropped into the matching folder.

## Plugins

Active plugins in `conf.d/ohmyzsh.zsh`:

- `git` - Git aliases and functions
- `zsh-autosuggestions` - Fish-like autosuggestions from command history
- `zsh-syntax-highlighting` - Real-time syntax highlighting
- `sudo` - Toggle `sudo` on the current command with `ESC ESC`

To add more plugins, edit the `plugins=()` array in `conf.d/ohmyzsh.zsh`.

## Functions

| Function | Description |
|----------|-------------|
| `fbak <path>` | Back up a file/directory with a timestamp suffix |
| `fextract <archive>` | Extract tar, zip, rar, 7z, gz, ... archives |
| `fweather [city]` | Show the weather (defaults to Hanoi) |
| `fenv` | Pick an environment variable with `fzf` and copy its value |
| `fcat <file>` | Print a file and copy its content to the clipboard |
| `fip` | Show public and local IP addresses |
| `fssh` | Pick a host from `~/.ssh/config` with `fzf` and connect |
| `fport [port]` | List listening ports and kill the selected process |
