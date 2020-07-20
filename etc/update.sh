source etc/functions.sh

set -eux

git pull origin master
git submodule update --init --recursive
git submodule foreach git pull origin master
zplug update