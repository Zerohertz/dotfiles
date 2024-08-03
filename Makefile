SHELL := /bin/zsh

.PHONY: all
all: zsh p10k tmux nvim
ROOT_HOME := $(shell sudo -i bash -c 'echo $$HOME')

.PHONY: zsh
zsh:
	@ln -sf $(PWD)/.zshrc $(HOME)/.zshrc
	@sudo ln -sf $(PWD)/.zshrc $(ROOT_HOME)/.zshrc
	@sudo rm -rf $(ROOT_HOME)/.oh-my-zsh
	@sudo cp -r $(HOME)/.oh-my-zsh $(ROOT_HOME)/.oh-my-zsh

.PHONY: p10k
p10k:
	@ln -sf $(PWD)/.p10k.zsh $(HOME)/.p10k.zsh
	@sudo ln -sf $(PWD)/.p10k.zsh $(ROOT_HOME)/.p10k.zsh

.PHONY: tmux
tmux:
	@ln -sf $(PWD)/.tmux.conf $(HOME)/.tmux.conf

.PHONY: nvim
nvim:
	@mkdir -p $(HOME)/.config && rm -rf $(HOME)/.config/nvim
	@sudo mkdir -p $(ROOT_HOME)/.config && sudo rm -rf $(ROOT_HOME)/.config/nvim
	@ln -sf $(PWD)/.config/nvim $(HOME)/.config/nvim
	@sudo ln -sf $(PWD)/.config/nvim $(ROOT_HOME)/.config/nvim
	@cd $(PWD)/.config/nvim && git switch main


.PHONY: kitty
kitty:
	@rm -rf $(HOME)/.config/kitty
	@ln -sf $(PWD)/.config/kitty $(HOME)/.config/kitty
