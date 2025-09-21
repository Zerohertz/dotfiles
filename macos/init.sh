# -------- Brew -------- #
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# -------- Term -------- #
brew install --cask kitty
brew install --cask ghostty

# -------- Git -------- #
brew install git
brew install gnupg
brew install bat
brew install delta

# -------- Karabiner -------- #
brew install --cask karabiner-elements

# -------- Yabai -------- #
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
# csrutil enable --without fs --without debug --without nvram
# csrutil disable --with kext --with dtrace --with basesystem
# sudo nvram boot-args=-arm64e_preview_abi
# echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai
# yabai --start-service
# skhd --start-service

# -------- Dev -------- #
brew install gh

brew install cmake
brew install rust
brew install rustup
brew install rust-analyzer
brew install go
brew install openjdk@17
brew install openjdk@21

brew install uv
# brew install --cask miniconda
brew install nvm
brew install bun
curl -s "https://get.sdkman.io" | bash

brew install terraform
brew install --cask docker
brew install kubernetes-cli
brew install kubecolor

brew install just

brew install mysql-client
brew install mongodb-community-shell

brew install --cask postman
brew install --cask mactex

npm install -g @anthropic-ai/claude-code
npm install -g ccusage
npm install -g @google/gemini-cli

# -------- Neovim -------- #
brew install neovim
brew install --cask neovide
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-sarasa-gothic
brew install --cask font-meslo-for-powerlevel10k
brew install wget
brew install fd
brew install ripgrep
brew install lazygit
brew install luarocks
brew install fish
brew install imagemagick
brew install gs
brew install mmdbctl
pip install neovim isort black pylatexenc
npm install -g neovim

# -------- VSCode -------- #
brew install --cask visual-studio-code

# -------- CLI -------- #
brew install eza
brew install tmux
brew install speedtest-cli
brew install autojump
brew install neofetch
brew install btop

# -------- Util -------- #
brew install --cask betterdisplay
brew install --cask openvpn-connect
brew install --cask twingate
brew install --cask nextcloud
brew install --cask slack
brew install --cask discord

# defaults write -g ApplePressAndHoldEnabled -bool false
