#!/bin/sh

THIS=`pwd`
for i in screenrc vimrc zshrc gvimrc my.cnf vim ctags bashrc shrc ackrc
do
  ln -s $THIS/$i $HOME/.$i
done

# vim swap dir make
mkdir $HOME/.vim/swap

# git config
echo "doc/tags\ndoc/tags-ja" >> ~/.gitignore
git config --global user.name bobpp
git config --global user.email bobpp.asroma+github@gmail.com
git config --global color.ui auto
git config --global core.excludesfile ~/.gitignore
git config --global github.user bobpp
echo "please execute 'git config --global github.token <MY GITHUB TOKEN>'"

