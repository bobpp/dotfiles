source etc/functions.sh

# Mac only
if [[ $(uname) = "Darwin" ]]; then
  # Homebrew
  if [[ -z $(which brew 2>/dev/null) ]]; then
    show_progress "Installing Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  show_progress "Installing Homebrew Applications"
  brew bundle
  if [[ -f $DOTPATH/Brewfile.local ]]; then
    brew bundle --file=$DOTPATH/Brewfile.local
  fi

  # Visual Studio Code
  show_progress "Configure Visual Studio Code"
  if [[ ! -d ~/Library/Application\ Support/Code/User ]]; then
    mkdir -p ~/Library/Application\ Support/Code/User
  fi
  for file in $(ls $DOTPATH/application-configure/VisualStudioCode.Mac/*.json); do
    ln -sfnv $file ~/Library/Application\ Support/Code/User
  done
  if [[ $(which code) ]]; then
    for extension in $(cat $DOTPATH/application-configure/VisualStudioCode.Mac/extensions); do
      code --install-extension $extension
    done
  else
    echo "Install Visual Studio Code, console tools and run `make initialize`"
  fi
fi
