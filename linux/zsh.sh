#!/usr/bin/env bash

rm -f ~/.zshrc
rm -f ~/.p10k.zsh
rm -rf ~/.oh-my-zsh

SUDO=""
[ "${EUID}" -ne 0 ] && SUDO="sudo"

if ! command -v zsh >/dev/null 2>&1; then
    ${SUDO} apt-get update &&
        ${SUDO} apt-get install zsh -y &&
        ${SUDO} apt-get clean &&
        ${SUDO} rm -rf /var/lib/apt/lists/*
fi

echo "n" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "\n\033[1;36m⭐ ZSH (powerlevel10k) Installed! ⭐\n\n\033[0m\tRun the following command to switch to ZSH:\n\033[1;32m\tchsh -s \$(which zsh)\033[0m"
