run() {
	echo
	echo "> $*"
	echo
	eval "$*"
}


partition_disk() {
lsblk
run "cfdisk /dev/$1"
}


format_partitions() {
run "mkfs.ext4 /dev/$1$2"
run "mkfs.ext4 /dev/$1$3"
run "mkswap /dev/$1$4"
}


mount_partitions() {
run "mount /dev/$1$2 /mnt"
run "mount --mkdir /dev/$1$3 /mnt/home"
run "mount --mkdir /dev/$1$4 /mnt/boot/efi"
}


before() {
run 'timedatectl set-ntp true'

vared -p 'Enter disk to partition: ' -c disk
partition_disk "$disk"

lsblk
vared -p 'Enter root partition suffix: ' -c root
vared -p 'Enter home partition suffix: ' -c home
vared -p 'Enter swap partition suffix: ' -c swap
vared -p 'Enter efi partition suffix: ' -c efi

format_partitions "$disk" "$root" "$home" "$swap"
mount_partitions "$disk" "$root" "$home" "$efi"

# Enable swap volume
run "swapon /dev/$disk$swap"

run 'pacstrap /mnt base linux linux-firmware linux-headers man-db intel-ucode nvidia nvidia-utils xf86-video-intel iwd dhcpcd opendoas git zsh grub efibootmgr os-prober ntfs-3g'

run 'genfstab -U /mnt >> /mnt/etc/fstab'

lsblk

echo
echo '**********************************************************************'
echo "run 'cd /; mv /root/dots /mnt; arch-chroot /mnt; zsh dots/install.zsh'"
echo '**********************************************************************'
echo
}


setup_time() {
vared -p 'Enter timezone: [Region/city]: ' -c timezone
run "ln -sf '/usr/share/zoneinfo/$timezone' /etc/localtime"

run 'hwclock --systohc'
}


setup_locale() {
sed -i '/^#en_US.UTF-8 UTF-8/ s|^#*||' /etc/locale.gen
run "echo 'LANG=en_US.UTF-8' > /etc/locale.conf"
}


set_host() {
vared -p 'Enter hostname: ' -c hostname
run "echo $hostname > /etc/hostname"

sed -i "s|{HOST}|$hostname|g" dots/misc/hosts
run 'mv dots/misc/hosts /etc'
}


setup_users() {
run 'passwd'
run "useradd -m $1"
run "usermod -aG wheel,storage,power,docker,video $1"
run "passwd $1"
}


setup_grub() {
sed -i '/^#GRUB_DISABLE_OS_PROBER=false/ s|^#*||' /etc/default/grub
sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT/ s|"$| ibt=off"|' /etc/default/grub
run 'grub-install --target=x86_64-efi --bootloader-id=grub --recheck'
run 'grub-mkconfig -o /boot/grub/grub.cfg'
}


mid() {
setup_time

setup_locale

vared -p 'Enter username: ' -c username
setup_users "$username"

run 'systemctl enable dhcpcd.service'
run 'systemctl enable iwd.service'

setup_grub

run "mv dots /home/$username"

echo
echo '*********************************************************'
echo "run 'exit; umount -lR /mnt; reboot; zsh dots/install.zsh'"
echo '*********************************************************'
echo
}


setup_doas() {
sed -i "s|{USERNAME}|$(whoami)|g" dots/misc/doas.conf
run 'doas mv dots/misc/doas.conf /etc'
run 'doas ln -s /usr/bin/doas /usr/bin/sudo'
}


setup_nvidia() {
run 'chmod +x dots/misc/nvidia.shutdown'
run 'doas mv dots/misc/nvidia.shutdown /usr/lib/systemd/system-shutdown'
run 'doas mv dots/misc/nvidia.hook /etc/pacman.d/hooks'
doas sed -i 's|^MODULES=()$|MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)|' /etc/mkinitcpio.conf
run 'mkinitcpio -P'
}

setup_misc() {
for e in git nvim python rg sioyek templates tmux X11 yarn zsh; do
    run "mv dots/$e .config"
done
run 'mv dots/fonts .local/share'
run 'mv dots/scripts .local/bin'
run 'git clone https://github.com/tmux-plugins/tmux-resurrect .config/tmux/tmux-resurrect'
run 'ln -s .config/git .config/fd'
}


setup_neovim() {
run 'mv .config/nvim/spell.encoding.add .local/share/nvim'
run 'git clone https://github.com/savq/paq-nvim ~/.local/share/nvim/site/pack/paqs/start/paq-nvim'
cd .config/nvim
for e in 'init.lua' plugin after; do
    mv "$e" "t$e"
done
run 'nvim lua/paqs/paq.lua -c "so|PaqInstall|q"'
for e in 'init.lua' plugin after; do
    mv "t$e" "$e"
done
run 'cd ~/.local/share/nvim/site/pack/paqs/start/vim-hexokinase; make vim-hexokinase'
cd
}


setup_postgres() {
echo '**************************************'
echo "run 'initdb -D /var/lib/postgres/data'"
echo '**************************************'
run 'su -l postgres'
}


setup_zsh() {
chsh -s "$(which zsh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.config/zsh/zsh-syntax-highlighting
}


setup_fzf() {
git clone https://github.com/junegunn/fzf ~/.config/fzf
cd .config/fzf
./install --xdg --no-update-rc --no-fish --no-bash --completion --key-bindings
sed -i 's|.ssh|.config/ssh|g|' shell/completion.zsh
cd
}


setup_suckless() {
mkdir dev; cd dev
git clone https://github.com/barrett-ruth/sl.git; cd sl
git remote set-url origin git@github.com:barrett-ruth/sl.git
for e in dmenu dwm dwmb st; do
    cd "$e"
    TERMINFO=~/.local/share/terminfo make install
    make clean
    cd ..
done
cd
}


setup_ssh() {
sed -i '/#*IdentityFile/ s|.ssh|.config/ssh|g' ssh_config
sed -i '/#*IdentityFile/ s|^#*||g' ssh_config
sed -i '/#*AuthorizedKeysFile/ s|.ssh|.config/ssh|g' sshd_config
sed -i '/#*AuthorizedKeysFile/ s|^#*||g' sshd_config

vared -p 'Enter email to use for ssh account: ' -c email
run "ssh-keygen -t ed25519 -C $email"
eval "$(ssh-agent -s)"
run 'ssh-add ~/.config/ssh/id_ed25519'
xclip -sel c < ~/.config/ssh/id_ed25519.pub
run 'chromium --new-window github.com/settings/ssh/new'

echo
echo '*******************************************************'
echo 'Paste the contents of the clipboard into the key field.'
echo '*******************************************************'
echo
}


setup_misc_packages() {
run 'git clone https://github.com/barrett-ruth/wp.git'
cd wp
git remote set-url origin git@github.com:barrett-ruth/wp.git
cd ..

# neovim-nightly
run 'git clone https://aur.archlinux.org/neovim-nightly-bin.git'
cd neovim-nightly-bin
run 'makepkg -si'
cd ..
rm -rf neovim-nightly-bin

# hadolint-bin
run 'git clone https://aur.archlinux.org/hadolint-bin.git'
cd hadolint-bin
run 'makepkg -si'
cd ..
rm -rf hadolint-bin

# setroot
run 'git clone https://github.com/ttzhou/setroot.git'
cd setroot
sed -i 's|`imlib2-config --libs`|-lImlib2|' Makefile
run 'sudo make xinerama=1'
cd ..
rm -rf setroot

# sioyek
git clone 'https://aur.archlinux.org/sioyek-git.git'
cd sioyek-git
run 'makepkg -si'
cd ..
rm -rf sioyek-git

# chromium
run 'git clone https://aur.archlinux.org/ungoogled-chromium-xdg-bin.git'
cd ungoogled-chromium-xdg-bin
run 'makepkg -si'
cd ..
rm -rf ungoogled-chromium-xdg-bin

# clipmenu
run 'git clone https://aur.archlinux.org/clipmenu-git.git'
cd clipmenu-git
sed -i '/^depends*/ s|dmenu ||' PKGBUILD
run 'makepkg -si'
cd ..
rm -rf clipmenu-git
}


setup_pip() {
python -m ensurepip
pip install black curlylint flake8 isort jedi-language-server mypy neovim virtualenv yamllint
}


setup_yarn() {
yarn --use-yarnrc ~/.config/yarn/config global add @fsouza/prettierd @tailwindcss/language-server eslint_d neovim prettier pyright typescript typescript-language-server vim-language-server vscode-langservers-extracted
rm "$HOME/.yarnrc"
}


post() {
run 'doas pacman -S clang dash docker docker-compose exa fakeroot fd gcc go google-java-format jdk-openjdk jdtls imlib2 libxft libxinerama light lua-language-server make openssh patch pkgconf postgresql python ripgrep shellcheck shfmt tmux ttf-hanazono ttf-liberation xorg-server xorg-setxkbmap xorg-xinit xorg-xmodmap xorg-xrandr xorg-xrdb xorg-xset which xclip yarn'

setup_doas

setup_nvidia

doas sed -i '/^#HookDir/ s|^#*||' /etc/pacman.conf
doas sed -i '/^#ParallelDownloads/ s|^#*||' /etc/pacman.conf

run 'doas mv dots/misc/dash.hook /etc/pacman.d/hooks'
run 'doas mv dots/misc/zshenv /etc/zsh'

# Rebuild grub config to recognize Windows Boot Manager
run 'doas grub-mkconfig -o /boot/grub/grub.cfg'

run 'mkdir -p .config/ssh .local/share/nvim .local/bin'

setup_misc

setup_misc_packages

setup_neovim

setup_postgres

setup_zsh

setup_fzf

setup_suckless

setup_ssh

setup_yarn

setup_pip

# Cleanup
run 'rm -rf .bash* .cache .lesshst dots'

echo
echo '*************'
echo "run 'reboot'."
echo '*************'
echo
}



vared -p 'before, mid, or post install? [b/m/p] ' -c installation_status
case "$installation_status" in
b)
	before
	;;
m)
	mid
	;;
p)
	post
	;;
esac