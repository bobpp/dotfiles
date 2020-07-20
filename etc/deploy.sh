source $DOTPATH/etc/functions.sh
set -eux

find $DOTPATH/NOT_AUTO_DEPLOY -name 'deploy.sh' | xargs bash