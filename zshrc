# alias
source ${HOME}/.alias

# zplug install plugins
if [[ -f $HOME/.zplug/init.zsh ]]; then
  source $HOME/.zplug/init.zsh

  zplug "yous/vanilli.sh"
  zplug "zsh-users/zsh-completions"
  zplug "syohex/zsh-perl-completions"
  zplug "zsh-users/zsh-syntax-highlighting", defer:2
  
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
source ${HOME}/.zsh/no-correct.zsh

unsetopt promptcr

# history
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history

#----- cdr
autoload -Uz is-at-least
if is-at-least 4.3.11; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*' recent-dirs-max 5000
  zstyle ':chpwd:*' recent-dirs-default yes
  zstyle ':completion:*' recent-dirs-insert both
fi

# load peco functions
if [[ -n $(which peco 2>/dev/null) ]]; then
  for f (~/.zsh/peco-sources/*) source "${f}"
  bindkey '^r' peco-select-history
  bindkey '^o' peco-cdr
  bindkey '^g' peco-git-branch-checkout
fi

# my theme
source ${HOME}/.zsh/bobpp-theme.zsh

# Load host-specify configure
if [[ -e "$HOME/.zshrc.mine" ]]; then
  source "$HOME/.zshrc.mine"
fi

