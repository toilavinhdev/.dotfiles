# show public and local IP addresses
fip() {
  local pub_ip loc_ip
  pub_ip=$(curl -s --connect-timeout 2 ifconfig.me || echo "N/A")
  if command -v ip &>/dev/null; then
    loc_ip=$(ip route get 1.1.1.1 2>/dev/null | awk '{print $7}')
  elif command -v ipconfig &>/dev/null; then
    loc_ip=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr wlan0)
  else
    loc_ip=$(hostname -I 2>/dev/null | awk '{print $1}')
  fi
  echo "[fip] Public IP : ${pub_ip:-N/A}"
  echo "[fip] Local IP  : ${loc_ip:-N/A}"
}

# ssh to host from ~/.ssh/config
fssh() {
  local host
  host=$(grep -E '^Host [^*]' ~/.ssh/config | awk '{print $2}' | fzf) && ssh "$host"
}

# fport
# example: fport | fport 3000
fport() {
  local awkp='{n=split($9,a,":"); printf "%-7s %-8s %-18s %s\n", a[n], $2, $1, $9}'
  local list="sudo lsof -nP -iTCP -sTCP:LISTEN 2>/dev/null | sed 1d | awk '$awkp' | sort -n | awk '!s[\$1 FS \$2]++'"
  local kill_="execute-silent(kill -SIG {+2} 2>/dev/null || sudo kill -SIG {+2})+reload(sleep 0.3; $list)"
  sudo -v || return
  eval "$list" | fzf -m --reverse --height 10% --query "${1:-}" \
    --header "PORT    PID      PROCESS            ADDRESS" \
    --footer "C-r: RELOAD | C-w: SIGTERM (15) | C-x: SIGKILL (9)" \
    --bind "ctrl-w:${kill_//SIG/15}" \
    --bind "ctrl-x:${kill_//SIG/9}" \
    --bind "ctrl-r:reload($list)"
}