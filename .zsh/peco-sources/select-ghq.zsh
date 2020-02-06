function peco-select-ghq() {
    if [[ -n $(which ghq 2>/dev/null) ]]; then
        cd $(ghq root)/$(ghq list | peco)
    else
        echo "require ghq"
    fi
}