EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml .gitignore .editorconfig
CANDIDATES := $(wildcard .??*)
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

deploy:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

initialize:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init.sh

update:
	git pull origin master
	git submodule update --init --recursive
	git submodule foreach git pull origin master

configure-export:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/export.sh

