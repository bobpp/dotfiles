autoload -Uz colors
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes false
zstyle ':vcs_info:*' formats '(%s:%b)'
zstyle ':vcs_info:*' actionformats '%{$fg[red]%}(!! %s:%b !!)'

function _precmd_vcs_info() { LANG=en_US.utf-8 vcs_info }
add-zsh-hook precmd _precmd_vcs_info

PROMPT=$'%{$fg[yellow]%}(%n@%m) %{$fg[green]%}[%~] %{$fg[blue]%}%{$vcs_info_msg_0_%}%{$reset_color%}\n%(!.#.$) '
