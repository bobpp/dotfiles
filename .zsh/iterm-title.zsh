function iterm-title() {
  if [[ $(uname) != "Darwin" ]]; then
    echo "Cant use this on not Darwin!"
    return
  fi

  if [[ ! -v ITERM_PROFILE ]]; then
    echo "Cant use this not use iTerm"
    return
  fi

  if [[ -v STY ]]; then
    echo "Cant use this on GNU screen"
    return
  fi

  echo -ne "\033]0;${1}\007"
}
