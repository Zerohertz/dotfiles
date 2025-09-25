# ----------------------- ZSH ----------------------- #
export SHELL=/bin/zsh
export EDITOR="nvim"
export PATH=$PATH:$HOME/.local/bin
export OS=$(uname)

# ----------------------- FUNC ----------------------- #
_lazy_load() {
    local loader_func="$1"
    shift
    local commands=("$@")
    for cmd in "${commands[@]}"; do
        eval "$cmd() {
            unset -f ${commands[*]}
            $loader_func
            $cmd \"\$@\"
        }"
    done
}

# ----------------------- OS ----------------------- #
if [[ "$OS" == "Linux" ]]; then
    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
elif [[ "$OS" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
fi

# ----------------------- Go ----------------------- #
export GOROOT=$(go env GOROOT)
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# ----------------------- JAVA ----------------------- #
if [[ "$OS" == "Linux" ]]; then
    export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
    export PATH=$JAVA_HOME/bin:$PATH
elif [[ "$OS" == "Darwin" ]]; then
    export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
    export CPPFLAGS="-I/opt/homebrew/opt/openjdk@21/include"
    export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
fi

# ----------------------- PYTHON ----------------------- #
export UV_PYTHON_INSTALL_DIR=/opt/venv
_load_uv() {
    eval "$(uv generate-shell-completion zsh)"
}
_lazy_load _load_uv uv
_load_uvx() {
    eval "$(uvx --generate-shell-completion zsh)"
}
_lazy_load _load_uvx uvx
if [[ -f "${UV_PYTHON_INSTALL_DIR}/main/bin/activate" ]]; then
    source "${UV_PYTHON_INSTALL_DIR}/main/bin/activate"
fi

# ----------------------- NODE ----------------------- #
_load_nvm() {
    export NVM_DIR="$HOME/.nvm"
    if [[ "$OS" == "Linux" ]]; then
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    elif [[ "$OS" == "Darwin" ]]; then
        [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
        [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
    fi
}
_lazy_load _load_nvm node npm npx nvm nvim neovide kubectl kubecolor claude ccusage opencode gemini

# ----------------------- CREDENTIALS ----------------------- #
if [ -f $HOME/.env ]; then
  source $HOME/.env
fi
