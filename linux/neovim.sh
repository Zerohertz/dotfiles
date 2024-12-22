# ----------------------- ROOT ----------------------- #
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz &&
	tar -xzf nvim-linux64.tar.gz &&
	cp -r nvim-linux64/* /usr/local/ &&
	rm nvim-linux64.tar.gz && rm -rf nvim-linux64 &&
	curl -fsSL https://deb.nodesource.com/setup_20.x | bash - &&
	apt-get install -y ripgrep fd-find fzf fish luarocks nodejs &&
	npm install -g neovim tree-sitter-cli

# ----------------------- USER ----------------------- #
pip install --no-cache-dir neovim isort black
