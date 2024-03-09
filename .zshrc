# basic shell envs
[ -f $HOME/.shrc ] && source $HOME/.shrc

has() {
  type "$1" > /dev/null 2>&1
}

# zplug install plugins
# TODO: zplug の乗り換えもしくは homebrew 化
if [[ -f $HOME/.zplug/init.zsh ]]; then
  source $HOME/.zplug/init.zsh

  zplug "yous/vanilli.sh"
  # zplug "b4b4r07/enhancd", use:init.sh
  zplug "zsh-users/zsh-completions"
  zplug "plugins/git", from:oh-my-zsh
  zplug "plugins/bundler", from:oh-my-zsh
  zplug "plugins/docker", from:oh-my-zsh
  zplug "plugins/docker-compose", from:oh-my-zsh
  zplug "zsh-users/zsh-syntax-highlighting", defer:2

  # Load company specify plugins
  if [[ -f $HOME/.zplug.company ]]; then
    source $HOME/.zplug.company
  fi
  # Load host specify plugins
  if [[ -f $HOME/.zplug.mine ]]; then
    source $HOME/.zplug.mine
  fi

  # Install plugins if there are plugins that have not been installed
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi

  zplug load

  # Enhancd configure
  if zplug check "b4b4r07/enhancd"; then
    export ENHANCD_FILTER=peco
    export ENHANCD_DOT_SHOW_FULLPATH=1
  fi
fi

bindkey -e

# shell opts
unsetopt correct_all
unsetopt promptcr
setopt no_beep
setopt no_flow_control

# completion configure
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# history
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history

# load other plugins
for f (${HOME}/.zsh/*.zsh) source "${f}"

# add fpath
if [[ -e $(brew --prefix)/share/zsh/site-function ]]; then
  fpath=( $(brew --prefix)/share/zsh/site-function "${fpath[@]}" )
fi

# load peco functions
if has "peco" ; then
  for f (~/.zsh/peco-sources/*) source "${f}"

  bindkey '^r' peco-select-history
  bindkey '^g' peco-git-branch-checkout
  alias ghqcd=peco-move-select-ghq
  alias ghqcode=peco-code-select-ghq
  alias cdp=peco-move-projects
  alias codep=peco-open-code-projects
fi

# load mise
if has "mise" ; then
  eval "$(mise activate zsh)"
fi

# load starship
if has "starship" ; then
  eval "$(starship init zsh)"
fi

# Load company-specify configure
if [[ -e "$HOME/.zshrc.company" ]]; then
  source "$HOME/.zshrc.company"
fi

# Load host-specify configure
if [[ -e "$HOME/.zshrc.mine" ]]; then
  source "$HOME/.zshrc.mine"
fi
