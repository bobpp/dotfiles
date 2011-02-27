#!/bin/sh

THIS=`pwd`
for i in screenrc vimrc zshrc gvimrc my.cnf vim ctags bashrc shrc gitconfig
do
  ln -s $THIS/$i $HOME/.$i
done

# vim swap dir make
mkdir $HOME/.vim/swap

