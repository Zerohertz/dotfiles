# ----------------------- Rust ----------------------- #
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y &&
	zsh -c "source $HOME/.cargo/env && \
    rustup update && rustup component add rust-analyzer && exit"

# ----------------------- Java ----------------------- #
curl -fsSL https://get.sdkman.io | bash &&
	zsh -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
    sdk install gradle && sdk install springboot && exit"

# ----------------------- Python ----------------------- #
wget https://repo.anaconda.com/miniconda/Miniconda3-py311_24.5.0-0-Linux-x86_64.sh -O $HOME/miniconda.sh &&
	chmod +x $HOME/miniconda.sh &&
	$HOME/miniconda.sh -b -p $HOME/miniconda &&
	rm $HOME/miniconda.sh &&
	$HOME/miniconda/bin/conda init zsh
