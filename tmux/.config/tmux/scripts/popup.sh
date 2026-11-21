#!/usr/bin/env bash
# Persistent popup toggle for tmux.
#
# One detached tmux session ("tmux_popup") holds one window per tool; the popup only
# attaches a client to that session. Closing the popup detaches the client
# instead of killing the processes, so reopening keeps their state.
#
# Usage: popup.sh <name> [command...]
#   popup.sh git lazygit
#   popup.sh shell
#   popup.sh tmux vi ~/.config/tmux/tmux.conf
#
#   popup.sh --close [session]   hide the current popup (no-op outside one)
#
# Inside the popup the same name hides it, a different name switches window.

set -u

session="tmux_popup"

# Query the pane that triggered the script (works from menus and key bindings)
display() {
  if [ -n "${TMUX_PANE:-}" ]; then
    tmux display-message -p -t "$TMUX_PANE" "$1"
  else
    tmux display-message -p "$1"
  fi
}

# Detach the client attached to the popup session, which closes the popup
detach_popup() {
  local tty
  tty=$(tmux list-clients -t "$1" -F '#{client_tty}' 2>/dev/null | head -n 1)
  tmux detach-client ${tty:+-t "$tty"}
}

# Window id of a tool window, empty when it does not exist yet
window_for() {
  tmux list-windows -t "$session" -F '#{window_id} #{@popup-name}' 2>/dev/null |
    awk -v name="$1" '$2 == name { print $1; exit }'
}

# Hide the current popup, do nothing outside a popup
if [ "${1:-}" = "--close" ]; then
  current=${2:-$(display '#{session_name}')}
  # only the session created by this script carries the @popup marker
  if [ "$(tmux show-option -t "$current" -qv @popup 2>/dev/null)" = "on" ]; then
    detach_popup "$current"
  fi
  exit 0
fi

name=${1:-}
if [ -z "$name" ]; then
  echo "usage: popup.sh <name> [command...] | popup.sh --close [session]" >&2
  exit 1
fi
shift

inside=no
if [ "$(display '#{session_name}')" = "$session" ]; then
  inside=yes
fi

# Inside the popup: same tool hides, another tool switches window
if [ "$inside" = yes ]; then
  current_name=$(tmux list-windows -t "$session" -F '#{window_active} #{@popup-name}' |
    awk '$1 == 1 { print $2; exit }')
  if [ "$current_name" = "$name" ]; then
    detach_popup "$session"
    exit 0
  fi
  # windows opened from inside reuse the project dir of the outer pane
  cwd=$(tmux show-option -t "$session" -qv @popup-cwd)
  [ -n "$cwd" ] || cwd=$(display '#{pane_current_path}')
else
  cwd=$(display '#{pane_current_path}')
fi

# Create the session or the tool window on first use
if ! tmux has-session -t "$session" 2>/dev/null; then
  win=$(tmux new-session -d -P -F '#{window_id}' -s "$session" -n "$name" -c "$cwd" "$@")
  tmux set-option -t "$session" status off
  # marker used by --close
  tmux set-option -t "$session" @popup on
  # exit the attached client when the last window closes
  tmux set-option -t "$session" detach-on-destroy on
else
  win=$(window_for "$name")
  if [ -z "$win" ]; then
    win=$(tmux new-window -d -P -F '#{window_id}' -t "$session:" -n "$name" -c "$cwd" "$@")
  fi
fi

# Keep a stable window name and remember the tool name on the window
tmux set-option -w -t "$win" @popup-name "$name"
tmux set-option -w -t "$win" automatic-rename off
tmux rename-window -t "$win" "$name"
tmux select-window -t "$win"

if [ "$inside" = yes ]; then
  # already attached: switching the window is enough
  exit 0
fi

# Remember the outer project dir for windows opened from inside the popup
tmux set-option -t "$session" @popup-cwd "$cwd"

width=$(tmux show-option -gqv @popup-width)
height=$(tmux show-option -gqv @popup-height)
border=$(tmux show-option -gqv @color-primary)
text=$(tmux show-option -gqv @color-white)

tmux display-popup -E -b rounded \
  -S "fg=${border:-#ffa040}" \
  -s "fg=${text:-#cdd6f4}" \
  -w "${width:-80%}" \
  -h "${height:-80%}" \
  "tmux attach-session -t '$session'"
