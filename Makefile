.PHONY: all
all: zsh p10k tmux nvim

.PHONY: zsh
zsh:
	@ln -sf ${PWD}/.zshrc ${HOME}/.zshrc

.PHONY: p10k
p10k:
	@ln -sf ${PWD}/.p10k.zsh ${HOME}/.p10k.zsh

.PHONY: tmux
tmux:
	@ln -sf ${PWD}/.tmux.conf ${HOME}/.tmux.conf

.PHONY: nvim
nvim:
	@rm -rf ${HOME}/.config/nvim
	@ln -sf ${PWD}/.config/nvim ${HOME}/.config/nvim
	@cd ${HOME}/.config/nvim && git switch main

.PHONY: kitty
kitty:
	@rm -rf ${HOME}/.config/kitty
	@ln -sf ${PWD}/.config/kitty ${HOME}/.config/kitty
