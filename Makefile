SHELL := /bin/zsh
USER := $(shell whoami)
ROOT_HOME := $(shell echo ~root)

.PHONY: all
all: git zsh p10k tmux nvim

.PHONY: git
git:
	@git pull origin main --recurse-submodules

.PHONY: zsh
zsh:
	@ln -sf $(PWD)/.zshrc $(HOME)/.zshrc
ifneq ($(USER), root)
	@sudo ln -sf $(PWD)/.zshrc $(ROOT_HOME)/.zshrc
	@sudo rm -rf $(ROOT_HOME)/.oh-my-zsh
	@sudo cp -r $(HOME)/.oh-my-zsh $(ROOT_HOME)/.oh-my-zsh
	@sudo mkdir -p $(ROOT_HOME)/.cache && sudo cp -r $(HOME)/.cache/gitstatus $(ROOT_HOME)/.cache/gitstatus
endif

.PHONY: p10k
p10k:
	@ln -sf $(PWD)/.p10k.zsh $(HOME)/.p10k.zsh
ifneq ($(USER), root)
	@sudo ln -sf $(PWD)/.p10k.zsh $(ROOT_HOME)/.p10k.zsh
endif

.PHONY: tmux
tmux:
	@ln -sf $(PWD)/.tmux.conf $(HOME)/.tmux.conf

.PHONY: nvim
nvim:
	@mkdir -p $(HOME)/.config && rm -rf $(HOME)/.config/nvim
	@ln -sf $(PWD)/.config/nvim $(HOME)/.config/nvim
ifneq ($(USER), root)
	@sudo mkdir -p $(ROOT_HOME)/.config && sudo rm -rf $(ROOT_HOME)/.config/nvim
	@sudo ln -sf $(PWD)/.config/nvim $(ROOT_HOME)/.config/nvim
	@mkdir -p $(HOME)/.cache/nvim $(HOME)/.local/share/nvim
	@sudo mkdir -p $(ROOT_HOME)/.cache && sudo ln -sf $(HOME)/.cache/nvim $(ROOT_HOME)/.cache
	@sudo mkdir -p $(ROOT_HOME)/.local/share && sudo ln -sf $(HOME)/.local/share/nvim $(ROOT_HOME)/.local/share
endif
	@cd $(PWD)/.config/nvim && git switch main

.PHONY: kitty
kitty:
	@rm -rf $(HOME)/.config/kitty
	@ln -sf $(PWD)/.config/kitty $(HOME)/.config/kitty
