source $DOTPATH/etc/functions.sh

SSH_DOTPATH="$DOTPATH/NOT_AUTO_DEPLOY/ssh"
show_progress "Deploy SSH configures"

set -eux
mkdir "$HOME/.ssh/conf.d"
ln -sf "$SSH_DOTPATH/.ssh/config" $HOME/.ssh/config
for path in $(find "$SSH_DOTPATH/.ssh/conf.d/" -type f | grep -v '.keep')
do
  ln -sf $path $HOME/.ssh/conf.d
done