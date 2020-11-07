source etc/functions.sh

set -eux

git pull origin master
git submodule update --init --recursive
git submodule foreach git pull origin master

if [[ -f $HOME/.zplug/init.zsh ]]; then
  set +xe
  source $HOME/.zplug/init.zsh
  zplug update
fi