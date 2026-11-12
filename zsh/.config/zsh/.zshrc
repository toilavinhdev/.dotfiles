# .zshrc is used for interactive shells

# load config files
if [ -d "$ZDOTDIR/conf.d" ]; then
  for file in "$ZDOTDIR/conf.d/"*.zsh; do
    [ -r "$file" ] && source "$file"
  done
  unset file
fi

# load function files
if [ -d "$ZDOTDIR/func.d" ]; then
  for file in "$ZDOTDIR/func.d/"*.zsh; do
    [ -r "$file" ] && source "$file"
  done
  unset file
fi

# status banner (cache 15 minutes)
banner_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh-status-banner"
mkdir -p "${banner_cache:h}"

status_banner() {
  echo -e "
  \033[1;30muser @ host :\033[0m $(whoami)@$(hostname)
  \033[1;30mos          :\033[0m $(. /etc/os-release && echo $PRETTY_NAME)
  \033[1;30mkernel      :\033[0m $(uname -r)
  \033[1;30mip          :\033[0m $(hostname -I | awk '{print $1}')
  \033[1;30mmemory      :\033[0m $(free -h | awk '/Mem:/ {print $3" / "$2}')
  \033[1;30mdisk        :\033[0m $(df -h / | awk 'NR==2 {print $3" / "$2}')
  \033[1;30muptime      :\033[0m $(uptime -p | sed 's/up //')

  \033[30m███\033[31m███\033[32m███\033[33m███\033[34m███\033[35m███\033[36m███\033[37m███\033[0m
"
}
# check cache expiration and patch cache
if [[ -n $(find "$banner_cache" -mmin -15 2>/dev/null) ]]; then
  cat "$banner_cache"
else
  status_banner | tee "$banner_cache"
fi

unset banner_cache