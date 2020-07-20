# Load host-specify configure
if [[ -e "$HOME/.zshenv.mine" ]]; then
	source "$HOME/.zshenv.mine"
fi

# Load company-specify configure
if [[ -e "$HOME/.zshenv.company" ]]; then
	source "$HOME/.zshenv.company"
fi
