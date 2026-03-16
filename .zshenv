# ----------------------- ZSH ----------------------- #
typeset -U path

path=("$HOME/.local/bin" $path)
export SHELL=/bin/zsh
export EDITOR="nvim"
export OS=$(uname)

# ----------------------- OS ----------------------- #
if [[ "$OS" == "Linux" ]]; then
    export LANG="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
fi

# ----------------------- C++ ----------------------- #

# ----------------------- Go ----------------------- #
export GOPATH=$HOME/go

# ----------------------- RUST ----------------------- #
. "$HOME/.cargo/env"

# ----------------------- JAVA ----------------------- #

# ----------------------- PYTHON ----------------------- #
export UV_PYTHON_INSTALL_DIR=/opt/venv

# ----------------------- NODE ----------------------- #
