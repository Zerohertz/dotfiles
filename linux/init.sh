sudo apt-get update
sudo apt-get upgrade
sudo reboot

sudo timedatectl set-timezone Asia/Seoul
timedatectl

# ----------------------- SSD ----------------------- #
lsblk
sudo lvscan
sudo lvextend -l +100%FREE -n /dev/ubuntu-vg/ubuntu-lv
lsblk
sudo resize2fs /dev/ubuntu-vg/ubuntu-lv

# ----------------------- Backup ----------------------- #
sudo mkdir -p /mnt/HDD
sudo mount -t exfat /dev/sda1 /mnt/HDD
cp -r --no-preserve=mode /mnt/HDD/backup/Zerohertz ./

# ----------------------- Git ----------------------- #
git config --global user.name Zerohertz
git config --global user.email ohg3417@gmail.com
git config --global credential.helper store
gpg --full-generate-key # 1, 4096, 0, y
gpg --armor --export ${FINGERPRINT}
echo -e "default-cache-ttl 28800\nmax-cache-ttl 28800" >>~/.gnupg/gpg-agent.conf
killall gpg-agent
git config --global user.signingkey ${FINGERPRINT}
git config --global commit.gpgsign true
git config --global gpg.program gpg

# ----------------------- ZSH ----------------------- #
sudo apt-get update
sudo apt-get install -y make
curl -fsSL https://raw.githubusercontent.com/Zerohertz/dotfiles/main/linux/zsh.sh | bash &&
	sudo chsh -s $(which zsh) && $HOME/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus/install -f &&
	mkdir -p $HOME/.config && git clone https://github.com/Zerohertz/dotfiles $HOME/dotfiles --recurse-submodules && cd $HOME/dotfiles &&
	make
chsh -s $(which zsh) $(whoami)
sudo chsh -s $(which zsh) root

# ----------------------- UFW ----------------------- #
sudo apt-get install -y ufw
sudo ufw status verbose
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 10230
sudo ufw enable
sudo ufw status verbose

# ----------------------- Fail2ban ----------------------- #
sudo apt-get install -y fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
sudo service fail2ban status
sudo cp ${PWD}/config/etc/fail2ban/jail.local /etc/fail2ban/jail.local
sudo cp ${PWD}/config/etc/fail2ban/action.d/slack_notifications.conf /etc/fail2ban/action.d/slack_notifications.conf
sudo cp ${PWD}/config/usr/lib/systemd/system/fail2ban.service /usr/lib/systemd/system/fail2ban.service
sudo service fail2ban restart

# ----------------------- Google OTP ----------------------- #
sudo apt-get install -y libpam-google-authenticator
google-authenticator
sudo cp ${PWD}/config/etc/pam.d/sshd /etc/pam.d/sshd
sudo cp ${PWD}/config/etc/ssh/sshd_config /etc/ssh/sshd_config
sudo systemctl restart ssh
