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
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/zerohertz/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/zerohertz/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/zerohertz/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/zerohertz/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# ----------------------- ZSH ----------------------- #
export SHELL=/usr/bin/zsh
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
alias exd="docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs sudo docker rm"
alias rmi="docker image prune -a"

# ----------------------- K8S ----------------------- #
if command -v kubectl &> /dev/null; then
    source <(kubeadm completion zsh)
    source <(kubectl completion zsh)
    alias k="kubectl"
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
export GOROOT=/usr/local/go
export PATH=$GOROOT/bin:$PATH
alias gg="go run main.go"

# ----------------------- JAVA ----------------------- #
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
export PATH=$JAVA_HOME/bin:$PATH
alias jj="java Main.java"

# ----------------------- NODE ----------------------- #
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ----------------------- ETC ----------------------- #
if command -v kitten &> /dev/null; then
    alias ssh="kitten ssh"
    alias icat="kitten icat"
fi

alias rsync="rsync -avhzP -e ssh"

alias tn="tmux new -s"
alias tl="tmux ls"
alias ta="tmux attach -t"

alias lint="isort . && black ."
export PROMPT_EOL_MARK=

# ----------------------- CREDENTIALS ----------------------- #
if [ -f $HOME/.env ]; then
  source $HOME/.env
fi
