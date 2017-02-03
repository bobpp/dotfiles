#!/bin/bash
# NOTE:
# curl -L http://dot.bobpp.jp/ | bash
# したらすてきにセットアップされる install.sh を作る

readonly DOTDIR="$HOME/.dotfiles"
readonly REPOSITORY_URL="https://github.com/bobpp/dotfiles.git"
set -e

echo "----------------------------------------------------------"
echo " Welcome to bobpp dotfiles!"
echo "----------------------------------------------------------"
echo "DOTDIR = $DOTDIR"
echo "REPOS = $REPOSITORY_URL"
echo ""

function is_command_exists () {
  which "$1" >/dev/null 2>&1
  return $?
}

# command checks
# 1. git
if ! is_command_exists "git"; then
  echo "need git"
  exit 1
fi

# 2. make
if ! is_command_exists "make"; then
  echo "need make"
  exit 1
fi

# directory exists check
if [ -d $DOTDIR ]; then
  echo "$DOTDIR already exists!!"
  exit 1
fi

echo "----------------------------------------------------------"
echo " Download dotfiles"
echo "----------------------------------------------------------"
git clone --recursive $REPOSITORY_URL $DOTDIR
cd $DOTDIR
echo ""

echo "----------------------------------------------------------"
echo " Deploy dotfiles"
echo "----------------------------------------------------------"
make deploy
echo ""

echo "----------------------------------------------------------"
echo " Initialize configure"
echo "----------------------------------------------------------"
make initalize
echo ""
