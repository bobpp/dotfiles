EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml .gitignore .editorconfig
CANDIDATES := $(wildcard .??*)
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

deploy:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/deploy.sh

initialize:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init.sh

update:
	@DOTPATH=$(DOTPATH) zsh $(DOTPATH)/etc/update.sh

export:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/export.sh
