function homebrew-search-undep-formulas() {
    for i in $(brew list -1 --formula)
    do
        uses=$(brew uses --install $i)
        if [ -z $uses ]; then
            echo $i
        fi
    done
}
