function ptvim () {
	vim $(pt "$@" | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}
zle -N ptvim

