#!/bin/sh

THIS=`pwd`
for i in screenrc vimrc zshrc gvimrc my.cnf vim ctags bashrc shrc gitconfig ackrc
do
  ln -s $THIS/$i $HOME/.$i
done

# vim swap dir make
mkdir $HOME/.vim/swap

