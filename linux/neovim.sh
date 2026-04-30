# ----------------------- ROOT ----------------------- #
bash <(curl -fsSL https://raw.githubusercontent.com/Zerohertz/nvim/refs/heads/main/scripts/install.sh)
apt-get install -y ripgrep fd-find fzf fish luarocks

# ----------------------- USER ----------------------- #
pip install --no-cache-dir neovim
