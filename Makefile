EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml .gitignore .editorconfig
CANDIDATES := $(wildcard .??*)
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

deploy:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

initialize:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init.sh

update:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/update.sh

configure-export:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/export.sh

