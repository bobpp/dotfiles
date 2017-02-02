autoload -Uz vcs_info
precmd () { vcs_info }
zstyle ':vcs_info:git:*' check-for-changes false
zstyle ':vcs_info:*' formats '(%s:%b)'

autoload -Uz colors

setopt prompt_subst
PROMPT=$'%{$fg[yellow]%}(%n@%m) %{$fg[green]%}[%~] %{$fg[blue]%}%{$vcs_info_msg_0_%}%{$reset_color%}\n%(!.#.$) '
