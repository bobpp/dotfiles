setopt prompt_subst

# Setting Color
local ORANGE=$'%{[33m%}'
local GREEN=$'%{[32m%}'
local BLUE=$'%{[34m%}'
local DEFAULT=$'%{[m%}'
PROMPT=$ORANGE'(%n@%m) '$GREEN'[%~]'$BLUE' $(git_info)'$DEFAULT$'\n%(!.#.$) '

function git_info() {
	local info

	if test -z $(git rev-parse --git-dir 2> /dev/null); then
		info=''
	else
		info="(git:${$(git symbolic-ref HEAD 2> /dev/null)#refs/heads/})"
	fi
	echo -n "$info"
}
