# -------- Brew -------- #
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# -------- Kitty -------- #
brew install kitty

# -------- Git -------- #
brew install git
brew install gnupg

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
brew install openjdk@17
curl -s "https://get.sdkman.io" | bash
brew install go
brew install rust
brew install node
brew install --cask docker
brew install --cask postman

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

# -------- Neovim -------- #
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
brew install neofetch
