# ----------------------- ROOT ----------------------- #
apt-get install -y python3.12-venv
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz &&
	tar -xzf nvim-linux64.tar.gz &&
	cp -r nvim-linux64/* /usr/local/ &&
	rm nvim-linux64.tar.gz && rm -rf nvim-linux64 &&
	apt-get clean && rm -rf /var/lib/apt/lists/* &&
	curl -fsSL https://deb.nodesource.com/setup_20.x | bash - &&
	apt-get install -y ripgrep fish nodejs luarocks &&
	npm install -g neovim

# ----------------------- USER ----------------------- #
pip install --no-cache-dir neovim isort black
