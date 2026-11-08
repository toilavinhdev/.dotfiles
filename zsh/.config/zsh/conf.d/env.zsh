# environment

# local variable
export PATH="$HOME/.local/bin:$PATH"

# history command
export HISTFILE="$HOME/.config/zsh/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion