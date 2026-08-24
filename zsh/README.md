# Zsh Configuration

## File Overview

| File | Description |
|------|-------------|
| `.zshenv` | Contains exported environment variables (loaded for all shell types) |
| `.zprofile` | Contains environment variables and shell-specific options for login shells |
| `.zshrc` | Contains settings for interactive shell (Oh My Zsh, theme, plugins) |
| `.zlogin` | Contains instructions to execute on session login (sourced after .zshrc) |
| `.zlogout` | Contains instructions to execute on session logout |

## Load Order

```
.zshenv → .zprofile → .zshrc → .zlogin → (session ends) → .zlogout
```

## Structure

```
~/.dotfiles/zsh/
├── .zshenv                          # Sets ZDOTDIR to ~/.config/zsh
└── .config/zsh/
    ├── .zshenv.example              # Example: environment variables
    ├── .zprofile.example            # Example: login shell config
    ├── .zshrc                       # Active: interactive shell config
    ├── .zlogin.example              # Example: post-login instructions
    └── .zlogout.example             # Example: logout instructions
```

## Plugins

Current active plugins in `.zshrc`:

- `git` - Git aliases and functions
- `zsh-autosuggestions` - Fish-like autosuggestions from command history

To add more plugins, edit the `plugins=()` array in `.config/zsh/.zshrc`.
