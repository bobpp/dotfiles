# .zshrc

# load base setting rc
[ -f $ZDOTDIR/.shrc ] && source $ZDOTDIR/.shrc
[ -f $HOME/.shrc ] && source $HOME/.shrc

# bindkey for Emacs mode
bindkey -e

# dabbrev
HARDCOPYFILE=$HOME/.screen-hardcopy
touch $HARDCOPYFILE
dabbrev-complete () {
        local reply lines=80
        screen -X eval "hardcopy -h $HARDCOPYFILE"
        reply=($(sed '/^$/d' $HARDCOPYFILE | sed '$ d' | tail -$lines))
        compadd - "${reply[@]%[*/=@|]}"
}

zle -C dabbrev-complete menu-complete dabbrev-complete
bindkey '^o' dabbrev-complete
bindkey '^o^_' reverse-menu-complete

# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
autoload -U compinit; compinit

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

autoload zed

autoload -U colors; colors

setopt auto_cd # Auto Current Directory
setopt auto_list
setopt auto_menu
setopt magic_equal_subst

# Share History
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history

unsetopt promptcr

# Aliases
setopt complete_aliases     # aliased ls needs if file/dir completions work

case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

alias -g G='| grep'
alias -g L='| less'
alias -g 2U='| nkf -wu' # nkfによる文字コード変換 tailなどにどうぞ
alias -g FSVN='| cut -b8-' # svn stの結果から変更ありファイルリストのみ抜き出す

# Prompt
setopt prompt_subst

# Setting Color
local ORANGE=$'%{[33m%}'
local GREEN=$'%{[32m%}'
local BLUE=$'%{[34m%}'
local DEFAULT=$'%{[m%}'
PROMPT=$ORANGE'(%n@%m) '$GREEN'[%~]'$BLUE' $(git_info)'$DEFAULT$'\n%(!.#.$) '
# End of Prompt

# Show Latest Command for GNU Screen
# by http://nijino.homelinux.net/diary/200206.shtml#200206141
if [ "$TERM" = "screen" ]; then
	chpwd () { echo -n "_`dirs`\\" }
	preexec() {
		# see [zsh-workers:13180]
		# http://www.zsh.org/mla/workers/2000/msg03993.html
		emulate -L zsh
		local -a cmd; cmd=(${(z)2})
		case $cmd[1] in
			fg)
				if (( $#cmd == 1 )); then
					cmd=(builtin jobs -l %+)
				else
					cmd=(builtin jobs -l $cmd[2])
				fi
				;;
			%*) 
				cmd=(builtin jobs -l $cmd[1])
				;;
			sudo)
				if (( $#cmd >= 2)); then
					cmd[1]="s*$cmd[2]"
				fi
				;&	
			cd)
				if (( $#cmd == 2)); then
					cmd[1]=$cmd[2]
				fi
				;&
			*)
				echo -n "k$cmd[1]:t\\"
				return
				;;
		esac

		local -A jt; jt=(${(kv)jobtexts})

		$cmd >>(read num rest
			cmd=(${(z)${(e):-\$jt$num}})
			echo -n "k$cmd[1]af:t\\") 2>/dev/null
	}
	chpwd
fi

# Background jobs executed notifier.
function jobs_mail () {
	local mail=$1

	while :
	do
		builtin jobs | grep -q .
		if [[ $? != 0 ]]; then
			break
		fi

		sleep 5
	done

	echo "bg jobs finished!" | mail -s'Jobs finished' $mail
}


function git_info() { 
	local info 

	if test -z $(git rev-parse --git-dir 2> /dev/null); then 
		info='' 
	else 
		info="(git:${$(git symbolic-ref HEAD 2> /dev/null)#refs/heads/})" 
	fi
	echo -n "$info"
}

# load user .zshrc configuration file
[ -f $ZDOTDIR/.zshrc.mine ] && source $ZDOTDIR/.zshrc.mine
[ -f $HOME/.zshrc.mine ] && source $HOME/.zshrc.mine

