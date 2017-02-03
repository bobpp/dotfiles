autoload -Uz colors
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes false
zstyle ':vcs_info:*' formats "$fg[blue](%s:%b)"
zstyle ':vcs_info:*' actionformats "$fg[red](!! %s:%b !!)"

# NOTE: ここに precmd を定義してしまうことも考えたが、他の設定等で競合することも考慮し hook にする
function _precmd_vcs_info() { LANG=en_US.utf-8 vcs_info }
autoload -Uz add-zsh-hook
add-zsh-hook precmd _precmd_vcs_info

setopt prompt_subst
PROMPT=$'%{$fg[yellow]%}(%n@%m) %{$fg[green]%}[%~] %{$vcs_info_msg_0_%}%{$reset_color%}\n%(!.#.$) '
