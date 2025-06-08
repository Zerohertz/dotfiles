sudo su

# ----------------------- C++ ----------------------- #
apt-get install -y build-essential gcc cmake

# ----------------------- Go ----------------------- #
apt-get install -y golang

# ----------------------- Java ----------------------- #
apt-get install -y openjdk-17-jdk openjdk-21-jdk

# ----------------------- Python ----------------------- #
curl -LsSf https://astral.sh/uv/install.sh | sh -s -- --system
sudo mv $(which uv) /bin/uv
sudo mv $(which uvx) /bin/uvx
UV_PYTHON_INSTALL_DIR=/opt/venv uv python install 3.13
UV_PYTHON_INSTALL_DIR=/opt/venv uv venv /opt/venv/main --python 3.13 --prompt "main" --seed --color always

# ----------------------- Node ----------------------- #
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash &&
	export NVM_DIR="$HOME/.nvm" &&
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" &&
	nvm install 24 &&
	npm install -g neovim tree-sitter-cli &&
	chown -R zerohertz:zerohertz $HOME/.nvm &&
	mv $HOME/.nvm /home/zerohertz/.nvm &&
	ln -sf /home/zerohertz/.nvm $HOME/.nvm

# ----------------------- Terraform ----------------------- #
wget -O- https://apt.releases.hashicorp.com/gpg |
	gpg --dearmor |
	tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null &&
	echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" |
	tee /etc/apt/sources.list.d/hashicorp.list &&
	apt-get update &&
	apt-get install -y terraform

# ----------------------- Lazygit ----------------------- #
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') &&
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" &&
	tar xf lazygit.tar.gz lazygit &&
	install lazygit /usr/local/bin && rm lazygit*
