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
# DISABLE_AUTO_UPDATE="true"

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

source $ZSH/oh-my-zsh.sh

# load zaw.zsh
source $HOME/.zaw/zaw.zsh

# Load host-specify configure
if [[ -e "$HOME/.zshrc.mine" ]]; then
	source "$HOME/.zshrc.mine"
fi

