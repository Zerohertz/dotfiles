SHELL := /bin/zsh
USER := $(shell whoami)
ROOT_HOME := $(shell echo ~root)

.PHONY: linux
linux: zsh p10k tmux neofetch vim nvim git gpg

.PHONY: macos
macos: zsh p10k tmux neofetch vim nvim git gpg kitty ghostty yabai neovide claude opencode kix

.PHONY: zsh
zsh:
	@ln -sf $(PWD)/.zshenv $(HOME)/.zshenv
	@ln -sf $(PWD)/.zshrc $(HOME)/.zshrc
ifneq ($(USER), root)
	@sudo ln -sf $(PWD)/.zshenv $(ROOT_HOME)/.zshenv
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

.PHONY: neofetch
neofetch:
	@rm -rf $(HOME)/.config/neofetch
	@ln -sf $(PWD)/.config/neofetch $(HOME)/.config/neofetch

.PHONY: vim
vim:
	@ln -sf $(PWD)/.vimrc $(HOME)/.vimrc
ifneq ($(USER), root)
	@sudo ln -sf $(PWD)/.vimrc $(ROOT_HOME)/.vimrc
endif

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
	@cd $(PWD)/.config/nvim && git switch main && git pull origin main

.PHONY: git
git:
	@ln -sf $(PWD)/.gitconfig $(HOME)/.gitconfig

.PHONY: gpg
gpg:
	@mkdir -p $(HOME)/.gnupg
	@ln -sf $(PWD)/.gnupg/gpg-agent.conf $(HOME)/.gnupg/gpg-agent.conf

.PHONY: kitty
kitty:
	@rm -rf $(HOME)/.config/kitty
	@ln -sf $(PWD)/.config/kitty $(HOME)/.config/kitty

.PHONY: ghostty
ghostty:
	@rm -rf $(HOME)/.config/ghostty
	@ln -sf $(PWD)/.config/ghostty $(HOME)/.config/ghostty

.PHONY: yabai
yabai:
	@rm -rf $(HOME)/.config/yabai
	@rm -rf $(HOME)/.config/skhd
	@ln -sf $(PWD)/.config/yabai $(HOME)/.config/yabai
	@ln -sf $(PWD)/.config/skhd $(HOME)/.config/skhd

.PHONY: neovide
neovide:
	@rm -rf $(HOME)/.config/neovide
	@ln -sf $(PWD)/.config/neovide $(HOME)/.config/neovide

.PHONY: claude
claude:
	@npm install -g @anthropic-ai/claude-code
	@npm install -g ccusage
	@claude config set -g theme dark-daltonized
	-@claude mcp add -s user -t http context7 https://mcp.context7.com/mcp
	-@claude mcp add -s user sequential-thinking -- npx -y @modelcontextprotocol/server-sequential-thinking
	# -@claude mcp add -s user -t http github https://api.githubcopilot.com/mcp/ -H "Authorization: Bearer $(GITHUB_TOKEN)"
	# -@claude mcp add -s user playwright -- npx -y @playwright/mcp@latest
	@rm -rf $(HOME)/.claude/settings.json
	@ln -sf $(PWD)/.claude/settings.json $(HOME)/.claude/settings.json
	@rm -rf $(HOME)/.claude/commands
	@ln -sf $(PWD)/.claude/commands $(HOME)/.claude/commands
	@rm -rf $(HOME)/.claude/hooks
	@ln -sf $(PWD)/.claude/hooks $(HOME)/.claude/hooks
	@rm -rf $(HOME)/.claude/agents
	@ln -sf $(PWD)/.claude/agents $(HOME)/.claude/agents

.PHONY: opencode
opencode:
	@npm install -g opencode-ai@latest
	@rm -rf $(HOME)/.config/opencode
	@ln -sf $(PWD)/.config/opencode $(HOME)/.config/opencode
	@npx oh-my-opencode install

.PHONY: kix
kix:
	@curl -L https://github.com/Zerohertz/kix/releases/latest/download/kix-darwin-arm64.tar.gz | tar -xz
	@sudo mv kix /usr/local/bin/
