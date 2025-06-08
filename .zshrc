# ----------------------- ZSH ----------------------- #
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
    git
    docker
    tmux
    zsh-syntax-highlighting
    zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
OS=$(uname)
if [[ "$OS" == "Linux" ]]; then
    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
fi
export SHELL=/bin/zsh
export EDITOR="nvim"
dotsync() {
    cd ${HOME}/dotfiles && \
        git sync
}
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

# ----------------------- GPG ----------------------- #
export GPG_TTY=$TTY
# killall gpg-agent
# gpg-agent --daemon
gpgctl() {
	local act=$1
    local key=$2
	case "$act" in
	ls)
        echo "===================== Public Key ====================="
        gpg --list-keys
        echo "===================== Secret Key ====================="
        gpg --list-secret-keys
		;;
	delete)
        echo "===================== Public Key ====================="
        gpg --delete-keys $key
        echo "===================== Secret Key ====================="
        gpg --delete-secret-keys $key
		;;
	export)
        echo "===================== Public Key ====================="
        gpg --export $key > gpg-public-key.gpg
        echo "===================== Secret Key ====================="
        gpg --export-secret-keys $key > gpg-secret-key.gpg
        echo "===================== Ownertrust ====================="
        gpg --export-ownertrust > gpg-trust-settings.txt
		;;
	import)
        echo "===================== Public Key ====================="
        gpg --import gpg-public-key.gpg
        echo "===================== Secret Key ====================="
        gpg --import gpg-secret-key.gpg
        echo "===================== Ownertrust ====================="
        gpg --import-ownertrust gpg-trust-settings.txt
		;;
	*)
		echo "Wrong usage"
		;;
	esac
}

# ----------------------- UFW ----------------------- #
alias us="sudo ufw status numbered"
alias uall="sudo ufw allow"
alias udel="sudo ufw delete"
alias ufw-on="sudo ufw enable"
alias ufw-off="sudo ufw disable"

# ----------------------- FAIL2BAN ----------------------- #
alias jail="sudo fail2ban-client status sshd"

# ----------------------- DOCKER ----------------------- #
dev() {
    local name="${1:-tmp}"
    docker run \
        --name $name \
        --platform linux/amd64 \
        -v ./:/workspace \
        -v ~/.config/github-copilot:/home/zerohertz/.config/github-copilot \
        --rm -d \
        zerohertzkr/dev
}
de() {
    local name=$1
    docker exec -it $name zsh
}
alias drmc="docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs docker rm"
alias drmi="docker image prune -a"
# k8s_build() {
#     local image_name="$1"
#     docker build -t "$image_name" .
#     docker save -o "$image_name".tar "$image_name"
#     sudo ctr -n k8s.io i import "$image_name".tar
#     sudo ctr -n k8s.io i ls | grep "$image_name"
# }

# ----------------------- K8S ----------------------- #
# alias crmc="sudo crictl ps -a | grep 'Exited' | awk '{print $1}' | xargs -I {} sudo crictl rm {} || true"
alias crmi="sudo crictl rmi --prune"
_load_kubeadm() {
    source <(kubeadm completion zsh)
}
_lazy_load _load_kubeadm kubeadm
_load_kubectl() {
    source <(kubectl completion zsh)
    compdef kubecolor=kubectl
}
_lazy_load _load_kubectl kubectl kubecolor k ku wk kg kgp kc ka kd kdn kdf kex
if command -v kubectl &> /dev/null; then
    alias k="kubecolor"
    alias ku="kubecolor config use-context"
    alias wk="watch kubecolor"
    alias kg="kubecolor get"
    alias kgp="kubecolor get po"
    alias kc="kubecolor create"
    alias ka="kubecolor apply -f"
    alias kd="kubecolor delete"
    alias kdn="kubecolor delete ns"
    alias kdf="kubecolor delete po --force"
    alias kex="kubecolor exec -it"
fi

# ----------------------- K9S ----------------------- #
export PATH=$PATH:$HOME/.local/bin

# ----------------------- C++ ----------------------- #
alias cpp="g++ main.cpp -std=c++23 -o main"

# ----------------------- Go ----------------------- #
export GOROOT=$(go env GOROOT)
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
alias gg="go run main.go"

# ----------------------- JAVA ----------------------- #
if [[ "$OS" == "Linux" ]]; then
    export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
    export PATH=$JAVA_HOME/bin:$PATH
elif [[ "$OS" == "Darwin" ]]; then
    export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
    export CPPFLAGS="-I/opt/homebrew/opt/openjdk@21/include"
    export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
fi
alias jj="java Main.java"

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
source /opt/venv/main/bin/activate
alias lint="isort . && black ."

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
_lazy_load _load_nvm node npm npx nvm nvim

# ----------------------- Neovide ----------------------- #
# nssh () {
#     if [ -z "$1" ] || [ -z "$2" ]; then
#         echo "Usage: nssh <remote_port> <local_port>"
#         return 1
#     fi
#     bash -c "ssh -L ${2}:localhost:${1} zerohertz nvim --headless --listen localhost:${1}" &
#     neovide --server=localhost:$2
# }

# ----------------------- ETC ----------------------- #
if [[ "$OS" == "Linux" ]]; then
    [ -f /usr/share/autojump/autojump.sh ] && . /usr/share/autojump/autojump.sh
elif [[ "$OS" == "Darwin" ]]; then
    [ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
    code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}
    export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
fi
if [[ "$TERM" == "xterm-kitty" ]] && command -v kitten &> /dev/null; then
    alias ssh="kitten ssh"
    alias icat="kitten icat"
fi

unalias ls 2>/dev/null
ls() {
    command eza --icons "$@"
}
tree() {
    command eza --tree --icons "$@"
}

alias rsync="rsync -avhzP -e ssh"

alias tn="tmux new -s"
alias tl="tmux ls"
alias ta="tmux attach -t"

export PROMPT_EOL_MARK=

# ----------------------- CREDENTIALS ----------------------- #
if [ -f $HOME/.env ]; then
  source $HOME/.env
fi

# ----------------------- SDKMAN ----------------------- #
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
if [[ $EUID -ne 0 ]]; then
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
