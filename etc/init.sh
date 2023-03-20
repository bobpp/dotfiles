source etc/functions.sh

# Mac only
if [[ $(uname) = "Darwin" ]]; then
  # Homebrew
  if [[ -z $(which brew 2>/dev/null) ]]; then
    show_progress "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  show_progress "Installing Homebrew Applications"
  brew bundle
  if [[ -f $DOTPATH/Brewfile.local ]]; then
    brew bundle --file=$DOTPATH/Brewfile.local
  fi

  show_progress "Import configure from Mackup"
  mackup restore
fi
