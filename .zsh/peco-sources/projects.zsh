function peco-move-projects() {
    if [[ -v _bobpp_PROJECT_ROOT ]]; then
        cd $(find $_bobpp_PROJECT_ROOT -type d -maxdepth 1 -mindepth 1 | sort | peco)
    else
        echo 'not set $_bobpp_PROJECT_ROOT'
    fi
}

function peco-open-code-projects() {
    if [[ -v _bobpp_PROJECT_ROOT ]]; then
        if [[ -n $(which code 2>/dev/null) ]]; then
            code $(find $_bobpp_PROJECT_ROOT -type d -maxdepth 1 -mindepth 1 | sort | peco)
        else
            echo 'require Visual Studio Code.'
        fi
    else
        echo 'not set $_bobpp_PROJECT_ROOT'
    fi
}