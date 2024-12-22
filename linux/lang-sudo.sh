sudo su

# ----------------------- C++ ----------------------- #
apt-get install -y build-essential gcc

# ----------------------- Go ----------------------- #
wget https://go.dev/dl/go1.22.4.linux-amd64.tar.gz &&
	rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.4.linux-amd64.tar.gz && rm go1.22.4.linux-amd64.tar.gz

# ----------------------- Java ----------------------- #
apt-get install -y openjdk-17-jdk

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
