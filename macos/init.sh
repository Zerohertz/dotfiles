# -------- Brew -------- #
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# -------- Kitty -------- #
brew install kitty

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
brew install --cask miniconda
brew install cmake
brew install rust
brew install rustup
brew install rust-analyzer
brew install go
brew install openjdk@17
brew install openjdk@21
curl -s "https://get.sdkman.io" | bash
brew install uv
brew install nvm
brew install terraform
brew install --cask docker
brew install --cask postman

brew install bun
brew install mysql-client
brew install mongodb-community-shell

brew install kubernetes-cli
brew install kubecolor

# -------- Neovim -------- #
brew install neovim
brew install --cask neovide
brew install --cask font-hack-nerd-font
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

# -------- Util -------- #
brew install --cask slack
brew install --cask discord
brew install --cask nextcloud

# -------- Etc -------- #
brew install autojump
brew install neofetch
brew install bpytop

# defaults write -g ApplePressAndHoldEnabled -bool false
