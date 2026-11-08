# backup file with timestamp
# example: bak .zshrc
fbak() {
  [ -f "$1" ] || [ -d "$1" ] && cp -vr "$1" "$1.bak.$(date +%Y%m%d-%H%M%S)"
}

# extract any archive file automatically
# example: fextract archive.tar.gz
fextract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "[fextract] '$1' cannot be extracted via fextract()" ;;
    esac
  else
    echo "[fextract] '$1' is not a valid file"
  fi
}