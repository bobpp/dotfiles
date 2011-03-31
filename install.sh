#!/bin/sh

THIS=`pwd`

# links
for i in screenrc vimrc zshrc gvimrc my.cnf vim ctags bashrc shrc ackrc
do
  if [ -e $HOME/.$i ] ; then
    echo "Already exists $HOME/.$i"
  else
    ln -s $THIS/$i $HOME/.$i
  fi
done

# vim swap dir make
if [ -e $HOME/.vim/swap ] ; then
  echo "Already exists $HOME/.vim/swap"
else
  mkdir $HOME/.vim/swap
fi

# git config
echo "doc/tags\ndoc/tags-ja" >> ~/.gitignore
git config --global user.name bobpp
git config --global user.email bobpp.asroma+github@gmail.com
git config --global color.ui auto
git config --global core.excludesfile ~/.gitignore
git config --global github.user bobpp
echo "please execute 'git config --global github.token <MY GITHUB TOKEN>'"

