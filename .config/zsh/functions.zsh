# mkdir + cd
mkcd() {
  [[ $# -gt 1 ]] && return 1
  mkdir -p "$1" && cd "$1" || return 1
}

# archive compress
compress() {
  if [[ -n "$1" ]]; then
    local file=$1
    shift
    case "$file" in
        *.tar ) tar cf "$file" "$*" ;;
        *.tar.bz2 ) tar cjf "$file" "$*" ;;
        *.tar.gz ) tar czf "$file" "$*" ;;
        *.tgz ) tar czf "$file" "$*" ;;
        *.zip ) zip "$file" "$*" ;;
        *.rar ) rar "$file" "$*" ;;
        * ) tar zcvf "$file.tar.gz" "$*" ;;
    esac
  else
    echo 'usage: compress <foo.tar.gz> ./foo ./bar'
  fi
}

# archive extract
extract() {
  if [[ -f "$1" ]] ; then
    local filename=$(basename "$1")
    local foldername=${filename%%.*}
    local fullpath=$(perl -e 'use Cwd "abs_path";print abs_path(shift)' "$1")
    local didfolderexist=false
    if [[ -d "$foldername" ]]; then
      didfolderexist=true
      read -p "$foldername already exists, do you want to overwrite it? (y/n) " -n 1
      echo
      if [[ "$REPLY" =~ ^[Nn]$ ]]; then
          return
      fi
    fi
    mkdir -p "$foldername" && cd "$foldername"
    case "$1" in
      *.tar.bz2) tar xjf "$fullpath" ;;
      *.tar.gz) tar xzf "$fullpath" ;;
      *.tar.xz) tar Jxvf "$fullpath" ;;
      *.tar.Z) tar xzf "$fullpath" ;;
      *.tar) tar xf "$fullpath" ;;
      *.taz) tar xzf "$fullpath" ;;
      *.tb2) tar xjf "$fullpath" ;;
      *.tbz) tar xjf "$fullpath" ;;
      *.tbz2) tar xjf "$fullpath" ;;
      *.tgz) tar xzf "$fullpath" ;;
      *.txz) tar Jxvf "$fullpath" ;;
      *.zip) unzip "$fullpath" ;;
      *) echo "'$1' cannot be extracted via extract()" \
          && cd .. \
          && ! "$didfolderexist" \
          && rm -r "$foldername" ;;
    esac
  else
      echo "'$1' is not a valid file"
  fi
}

# fuzzy rg
frg() {
    rg --line-number \
        --column \
        --no-heading \
        --color=always \
        --colors='match:none' \
        --colors='path:fg:white' \
        --colors='line:fg:white' \
        "$@" . 2> /dev/null \
        | fzf --ansi
}

# kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]; then
      echo "$pid" | xargs kill -"${1:-9}"
  fi
}

# browse chrome history
ch() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  google_history="$HOME/.config/chromium/Default/History"
  open="mimeopen -n"

  cp -f "$google_history" /tmp/h
  sqlite3 -separator "$sep" /tmp/h \
      "select substr(title, 1, $cols), url
  from urls order by last_visit_time desc" \
      | awk -F "$sep" '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' \
      | fzf --ansi -m \
      | sed 's#.*\(https*://\)#\1#' \
      | xargs "$open" > /dev/null 2> /dev/null
}

# man search
fman() {
  man "$(apropos . | fzf | sed 's/ .*//')"
}
