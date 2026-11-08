# oh-my-zsh

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.config/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="toilavinhdev"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  sudo
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh