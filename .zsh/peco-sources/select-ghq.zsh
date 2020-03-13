function peco-move-select-ghq() {
    if [[ -n $(which ghq 2>/dev/null) ]]; then
        cd $(ghq root)/$(ghq list | sort | peco)
    else
        echo "require ghq"
    fi
}

function peco-code-select-ghq() {
    if [[ -n $(which ghq 2>/dev/null) ]]; then
        if [[ -n $(which code 2>/dev/null) ]]; then
            code $(ghq root)/$(ghq list | sort | peco)
        else
            "require code"
        fi
    else
        echo "require ghq"
    fi
}