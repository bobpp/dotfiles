# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bobpp"

# Custom plugin, theme dir
if [[ -e "$HOME/.oh-my-zsh-custom" ]]; then
	ZSH_CUSTOM="$HOME/.oh-my-zsh-custom"
fi

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-flow vagrant perl capistrano brew zsh-syntax-highlighting bundler npm)

# load Addtional Plugins
fpath=($HOME/.zsh/perl-completions $fpath)

#disable autocorrect
unsetopt correct_all

setopt HIST_IGNORE_ALL_DUPS

#----- cdr
autoload -Uz is-at-least
if is-at-least 4.3.11
then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*' recent-dirs-max 5000
  zstyle ':chpwd:*' recent-dirs-default yes
  zstyle ':completion:*' recent-dirs-insert both
fi

source $ZSH/oh-my-zsh.sh

function ssh_screen(){
  eval server=?${$#}
  screen -t $server ssh "$@"
}
if [ x$TERM = xscreen ]; then
  alias ssh=ssh_screen
fi

# load peco functions
if [[ -n $(which peco 2>/dev/null) ]]; then
  for f (~/.zsh/peco-sources/*) source "${f}"
  bindkey '^r' peco-select-history
  bindkey '^o' peco-cdr
  bindkey '^g' peco-git-branch-checkout
fi

# Load host-specify configure
if [[ -e "$HOME/.zshrc.mine" ]]; then
	source "$HOME/.zshrc.mine"
fi

