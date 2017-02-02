# alias
[ -f $HOME/.alias ] && source $HOME/.alias

# basic shell configure
[ -f $HOME/.shrc ] && source $HOME/.shrc
bindkey -e

# zplug install plugins
if [[ -f $HOME/.zplug/init.zsh ]]; then
  source $HOME/.zplug/init.zsh

  zplug "yous/vanilli.sh"
  zplug "zsh-users/zsh-completions"
  zplug "syohex/zsh-perl-completions"
  zplug "zsh-users/zsh-syntax-highlighting", defer:2
  zplug "b4b4r07/enhancd", use:init.sh
  
  # Install plugins if there are plugins that have not been installed
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi
  
  zplug load --verbose
fi

# no correct
unsetopt correct_all

unsetopt promptcr

# history
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history

# Enhancd configure
if zplug check "b4b4r07/enhancd"; then
  export ENHANCD_FILTER=peco
  export ENHANCD_DOT_SHOW_FULLPATH=1
fi

# load peco functions
if [[ -n $(which peco 2>/dev/null) ]]; then
  for f (~/.zsh/peco-sources/*) source "${f}"
  bindkey '^r' peco-select-history
  bindkey '^g' peco-git-branch-checkout
  if [[ -n $(which ghq 2>/dev/null) ]]; then
    alias ghqr='cd $(ghq root)/$(ghq list | peco)'
  fi
fi

# my theme
source ${HOME}/.zsh/bobpp-theme.zsh

# Load host-specify configure
if [[ -e "$HOME/.zshrc.mine" ]]; then
  source "$HOME/.zshrc.mine"
fi

