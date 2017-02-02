#!/bin/sh

THIS=`pwd`
git submodule update --init --recursive

# links
for i in screenrc vimrc zshenv zshrc gvimrc my.cnf vim ctags bashrc shrc ackrc module-starter alias xvimrc peco zsh zplug gitconfig gitignore config
do
  if [ -e $HOME/.$i ] ; then
    echo "Already exists $HOME/.$i"
  else
    ln -s $THIS/$i $HOME/.$i
  fi
done

# if this is Mac setting for Karabiner
if [[ $(uname) = "Darwin" ]]; then
  if [[ -e ~/Library/Preferences/org.pqrs.Karabiner.plist ]]; then
    echo "Already exists Karabiner configure"
	echo "when if you want overwrite after execute....."
	echo "   $ rm ~/Library/Preferences/org.pqrs.Karabiner.plist"
	echo "   $ cd ~/Library/Preferences"
	echo "   $ ln -s $THIS/application-configure/Karabiner/org.pqrs.Karabiner.plist"
  else
    cwd=$(pwd)
    cd ~/Library/Preferences/
    ln -s $THIS/application-configure/Karabiner/org.pqrs.Karabiner.plist
    cd $cwd
  fi
fi

