# check weather (default hanoi)
# example: weather ninh-binh
fweather() {
  curl -s "wttr.in/${1:-Hanoi}?format=3"
}

# view and copy environment variables
fenv() {
  local selected key val
  selected=$(env | sort | fzf)
  if [ -n "$selected" ]; then
    key=$(echo "$selected" | cut -d '=' -f1)
    val=$(echo "$selected" | cut -d '=' -f2-)
    if command -v clip.exe &>/dev/null; then
      echo -n "$val" | clip.exe
    elif command -v xclip &>/dev/null; then
      echo -n "$val" | xclip -selection clipboard
    elif command -v pbcopy &>/dev/null; then
      echo -n "$val" | pbcopy
    fi
    echo "[fenv] copy '$key' value to clipboard"
  fi
}

# copy ssh key file content to clipboard automatically
# example: fkey ~/.ssh/id_rsa
fcat() {
  local file="${1}"
  cat "$file"
  if [ -f "$file" ]; then
    if command -v clip.exe &>/dev/null; then
      # WSL2
      cat "$file" | clip.exe
    elif command -v xclip &>/dev/null; then
      # Linux X11
      cat "$file" | xclip -selection clipboard
    elif command -v wl-copy &>/dev/null; then
      # Linux Wayland
      cat "$file" | wl-copy
    elif command -v pbcopy &>/dev/null; then
      # macOS
      cat "$file" | pbcopy
    else
      echo "[fcat] clipboard tool not found"
      return 1
    fi
    echo "[fcat] copied to clipboard"
  else
    echo "[fcat] file not found '$file'"
    return 1
  fi
}