# ----------------------- OS ----------------------- #
if [[ "$OS" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    path=("/usr/local/bin" "/opt/homebrew/opt/libpq/bin" $path)
fi

# ----------------------- C++ ----------------------- #
if [[ "$OS" == "Darwin" ]]; then
    path=("${HOMEBREW_PREFIX}/opt/llvm/bin" $path)
fi

# ----------------------- Go ----------------------- #
if command -v go &>/dev/null; then
    export GOROOT=$(go env GOROOT)
    path=("$GOROOT/bin" "$GOPATH/bin" $path)
fi

# ----------------------- RUST ----------------------- #

# ----------------------- JAVA ----------------------- #
if [[ "$OS" == "Linux" ]] && command -v java &>/dev/null; then
    export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
    path=("$JAVA_HOME/bin" $path)
elif [[ "$OS" == "Darwin" ]] && [[ -d "/opt/homebrew/opt/openjdk@21" ]]; then
    path=("/opt/homebrew/opt/openjdk@21/bin" $path)
    export CPPFLAGS="-I/opt/homebrew/opt/openjdk@21/include"
    export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
fi

# ----------------------- PYTHON ----------------------- #
if [[ -f "${UV_PYTHON_INSTALL_DIR}/main/bin/activate" && "$(which python3)" != "${UV_PYTHON_INSTALL_DIR}/main/bin/python3" ]]; then
    path=("${UV_PYTHON_INSTALL_DIR}/main/bin" $path)
    export VIRTUAL_ENV="${UV_PYTHON_INSTALL_DIR}/main"
fi

# ----------------------- NODE ----------------------- #
