# Mac only
if [[ $(uname) = "Darwin" ]]; then
  # Karabiner configure
  ln -sfnv $DOTPATH/application-configure/org.pqrs.Karabiner.plist ~/Library/Preferences

  # Visual Studio Code
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
