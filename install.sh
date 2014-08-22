#!/bin/sh

THIS=`pwd`

# links
for i in screenrc vimrc zshrc gvimrc my.cnf vim ctags bashrc shrc ackrc module-starter alias oh-my-zsh oh-my-zsh-custom zaw xvimrc
do
  if [ -e $HOME/.$i ] ; then
    echo "Already exists $HOME/.$i"
  else
    ln -s $THIS/$i $HOME/.$i
  fi
done

# vim swap dir make
for i in $HOME/.vim/swap $HOME/.vim/bundle
do
  if [ -e $i ] ; then
    echo "Already exists $i"
  else
    mkdir $i
  fi
done

# git config
echo "doc/tags\ndoc/tags-ja" >> ~/.gitignore
git config --global user.name bobpp
git config --global user.email bobpp.asroma+github@gmail.com
git config --global color.ui auto
git config --global core.excludesfile ~/.gitignore
git config --global github.user bobpp
echo "please execute 'git config --global github.token <MY GITHUB TOKEN>'"

