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
elif [[ "$OS" == "Darwin" ]]; then
    export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
    code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}
    export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# ----------------------- ZSH ----------------------- #
export SHELL=/bin/zsh
export EDITOR="nvim"

# ----------------------- GPG ----------------------- #
export GPG_TTY=$TTY
# killall gpg-agent
# gpg-agent --daemon

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
        -v ./:/home/zerohertz/workspace \
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
if command -v kubeadm &> /dev/null; then
    source <(kubeadm completion zsh)
fi
if command -v kubectl &> /dev/null; then
    source <(kubectl completion zsh)
    alias k="kubectl"
    alias ku="kubectl config use-context"
    alias wk="watch kubectl"
    alias kg="kubectl get"
    alias kgp="kubectl get po"
    alias kc="kubectl create"
    alias ka="kubectl apply -f"
    alias kd="kubectl delete"
    alias kdn="kubectl delete ns"
fi

# ----------------------- K9S ----------------------- #
export PATH=$PATH:$HOME/.local/bin

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
    export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
    export CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include"
    export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
fi
alias jj="java Main.java"

# ----------------------- PYTHON ----------------------- #
alias lint="isort . && black ."

# ----------------------- NODE ----------------------- #
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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
unalias ls 2>/dev/null
ls() {
    command eza --icons "$@"
}
tree() {
    command eza --tree --icons "$@"
}

if [[ "$TERM" == "xterm-kitty" ]] && command -v kitten &> /dev/null; then
    alias ssh="kitten ssh"
    alias icat="kitten icat"
fi

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
