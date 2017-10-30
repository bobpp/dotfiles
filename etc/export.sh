# Mac only
if [[ $(uname) = "Darwin" ]]; then
  # Visual Studio Code
  if [[ $(which code) ]]; then
    code --list-extensions  > $DOTPATH/application-configure/VisualStudioCode.Mac/extensions
  fi
  if [[ -d ~/Library/Application\ Support/Code/User/ ]]; then
    pushd ~/Library/Application\ Support/Code/User
      for file_name in $(ls *.json); do
        if [[ ! -e $DOTPATH/application-configure/VisualStudioCode.Mac/$file_name ]]; then
          cp $file_name $DOTPATH/application-configure/VisualStudioCode.Mac/$file_name
          ln -sfnv $DOTPATH/application-configure/VisualStudioCode.Mac/$file_name ~/Library/Application\ Support/Code/User
        fi
      done
    popd
  fi
fi
