source etc/functions.sh

# Mac only
if [[ $(uname) = "Darwin" ]]; then
  # Homebrew
  if [[ -z $(which brew 2>/dev/null) ]]; then
    show_progress "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    show_progress "Load Homebrew envs"
    # Intel Mac
    if [[ -e /usr/local/bin/brew ]]; then
      eval $(/usr/local/bin/brew shellenv)
    fi
    # Apple Silicon Mac
    if [[ -e /opt/homebrew/bin/brew ]]; then
      eval $(/opt/homebrew/bin/brew shellenv)
    fi
  fi

  show_progress "Installing Homebrew Applications"
  brew bundle --file=$DOTPATH/Brewfile
  if [[ -f $DOTPATH/Brewfile.local ]]; then
    brew bundle --file=$DOTPATH/Brewfile.local
  fi

  show_progress "Import configure from Mackup"
  mackup restore
fi
