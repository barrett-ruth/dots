run() {
    echo
    echo "> $*"
    echo
    eval "$*"
}


format_partitions() {
run "mkfs.ext4 /dev/$1$2"
# currently using one root partition only
# run "mkfs.ext4 /dev/$1$3"
run "mkswap /dev/$1$4"
}


mount_partitions() {
run "mount /dev/$1$2 /mnt"
# currently using one root partition only
# run "mount --mkdir /dev/$1$3 /mnt/home"
run "mount --mkdir /dev/$1$4 /mnt/boot/efi"
}

if [ 1 -eq 2 ]; then
    echo
fi


before() {
run 'timedatectl set-ntp true'

lsblk
vared -p 'Enter disk to partition: ' -c disk
cfdisk "/dev/$disk"

lsblk
vared -p 'Enter root partition suffix: ' -c root
vared -p 'Enter home partition suffix: ' -c home
vared -p 'Enter swap partition suffix: ' -c swap
vared -p 'Enter efi partition suffix: ' -c efi

format_partitions "$disk" "$root" "$home" "$swap"
mount_partitions "$disk" "$root" "$home" "$efi"

# Enable swap volume
run "swapon /dev/$disk$swap"

run 'pacstrap /mnt base linux linux-firmware linux-headers dkms man-db intel-ucode nvidia nvidia-utils iwd dhcpcd opendoas git zsh zsh-syntax-highlighting zsh-completions grub efibootmgr os-prober ntfs-3g feh'

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
run "usermod -aG wheel,storage,power $1"
run "passwd $1"
}


setup_grub() {
sed -i '/^#GRUB_DISABLE_OS_PROBER=false/ s|^#*||' /etc/default/grub
sed -i '/^GRUB_GFXMODE/ s|auto|1920x1080x32|' /etc/default/grub
sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT/ s|"$| ibt=off"|' /etc/default/grub
sed -i '/^GRUB_TIMEOUT/ s|.$|-1|' /etc/default/grub
run 'grub-install --target=x86_64-efi --bootloader-id=grub --recheck'
run 'grub-mkconfig -o /boot/grub/grub.cfg'
}


setup_nvidia() {
run 'chmod +x dots/misc/nvidia.shutdown'
run 'mv dots/misc/nvidia.shutdown /usr/lib/systemd/system-shutdown'
run 'mv dots/misc/nvidia.hook /etc/pacman.d/hooks'
sed -i 's|^MODULES=()$|MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm i915)|' /etc/mkinitcpio.conf
run 'mkinitcpio -P'
}


setup_x11() {
# not using now
# run 'mv dots/misc/10-nvidia-rm-outputclass.conf /etc/X11/xorg.conf.d'
# run 'mv dots/misc/20-nvidia.conf /etc/X11/xorg.conf.d'
run 'mv dots/misc/30-libinput.conf /etc/X11/xorg.conf.d'
}


setup_transmission() {
run 'mv dots/misc/99-transmission.conf /etc/sysctl.d'
}


setup_doas() {
sed -i "s|{USERNAME}|$1|g" dots/misc/doas.conf
run 'mv dots/misc/doas.conf /etc'
cd /usr/bin
run 'ln -s doas sudo'
cd
}


setup_ssh_etc() {
sed -i '/#*IdentityFile/ s|.ssh|.config/ssh|g' /etc/ssh_config
sed -i '/#*IdentityFile/ s|^#*||g' /etc/ssh_config
sed -i '/#*AuthorizedKeysFile/ s|.ssh|.config/ssh|g' /etc/sshd_config
sed -i '/#*AuthorizedKeysFile/ s|^#*||g' /etc/sshd_config
}


setup_pacman() {
sed -i '/^#HookDir/ s|^#*||' /etc/pacman.conf
sed -i '/^#ParallelDownloads/ s|^#*||' /etc/pacman.conf
run 'mv dots/misc/dash.hook /etc/pacman.d/hooks'
}


mid() {
setup_time

setup_locale

vared -p 'Enter username: ' -c username
setup_users "$username"

setup_doas "$username"

run 'systemctl enable dhcpcd'
run 'systemctl enable sshd'
run 'systemctl enable postgresql'
run 'systemctl enable fstrim.timer'
run 'systemctl enable iwd'

run 'mv dots/misc/zshenv /etc/zsh'

setup_grub

setup_nvidia

setup_X11

setup_transmission

setup_ssh_etc

setup_pacman

run 'rm -rf dots'
run "doas $username git clone https://github.com/barrett-ruth/dots.git /home/$username/dots"

echo
echo '*********************************************************'
echo "run 'exit; umount -lR /mnt; reboot; zsh dots/install.zsh'"
echo '*********************************************************'
echo
}


setup_misc_configs() {
for e in git nvim python rg sioyek templates tmux X11 yarn zsh; do
    run "mv dots/$e .config"
done
run 'mv dots/fonts .local/share'
run 'mv dots/scripts .local/bin'
run 'git clone https://github.com/tmux-plugins/tmux-resurrect .config/tmux/tmux-resurrect'
cd .config
run 'ln -s git fd'
cd
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
cd
}


setup_postgres() {
echo '******************************************************'
echo "run 'su -l postgres; initdb -D /var/lib/postgres/data'"
echo '******************************************************'
run 'su'
}


setup_fzf() {
git clone https://github.com/junegunn/fzf ~/.config/fzf
cd .config/fzf
./install --xdg --no-update-rc --no-fish --no-bash --completion --key-bindings
sed -i 's|.ssh|.config/ssh|g' shell/completion.zsh
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


setup_ssh_key() {
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
run 'git clone https://aur.archlinux.org/jdtls.git'
cd jdtls
sed -i 's|*|linux|g' PKGBUILD
sed -i 's|${pkgdir}/usr|~/.local|g' PKGBUILD
makepkg -si
cd ..

run 'git clone https://aur.archlinux.org/shellcheck-bin.git'
cd shellcheck-bin
makepkg -si
cd ..

run 'git clone https://github.com/barrett-ruth/wp.git'
cd wp
git remote set-url origin git@github.com:barrett-ruth/wp.git
cd ..

# hadolint-bin
run 'git clone https://aur.archlinux.org/hadolint-bin.git'
cd hadolint-bin
run 'makepkg -si'
cd ..
rm -rf hadolint-bin

# sioyek
git clone 'https://aur.archlinux.org/sioyek-git.git'
cd sioyek-git
run 'makepkg -si'
cd ..
rm -rf sioyek-git

# chromium
# chrome://flags: {
#    Handling of extension MIME type requests: Always prompt for install
#    Remove Tabsearch Button: Enabled
#}
# chrome://new-tab-page -> customize {
#    shortcuts -> hide shortcuts
#    color & theme -> midnight blue
#}
# chrome://settings/searchEngines {
#    Arch Wikipedia, Github, ZLib site searches
# extensions: wikiwand, ublockorigin, react devtools, vimium c, clear new tab (background rgb(69, 87, 96, 1)), google translate
#}
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

setup_go() {
    go install github.com/lighttiger2505/sqls@latest
}


setup_yarn() {
yarn --use-yarnrc ~/.config/yarn/config global add @fsouza/prettierd @tailwindcss/language-server eslint_d neovim prettier pyright typescript typescript-language-server vim-language-server vscode-langservers-extracted
rm "$HOME/.yarnrc"
}


post() {
run 'doas pacman -S clang dash docker docker-compose exa fakeroot harfbuzz tree-sitter fd gcc go google-java-format jdk-openjdk jdtls libxft xf86-video-intel libxinerama libglvnd light lua-language-server make openssh patch pkgconf postgresql python ripgrep rustup shfmt tmux ttf-hanazono ttf-liberation xorg-server xorg-setxkbmap xorg-xinit xorg-xmodmap xorg-xrandr xorg-xrdb xorg-xset which xclip yarn pulseaudio mpv rsync transmission-cli jq socat'

run 'doas usermod -aG docker,video "$(whoami)"'

# Rebuild grub config to recognize Windows Boot Manager
run 'doas grub-mkconfig -o /boot/grub/grub.cfg'

run 'mkdir -p .config/ssh .local/share/nvim .local/bin'

setup_misc_configs

setup_misc_packages

setup_neovim

setup_postgres

chsh -s "$(which zsh)"

setup_fzf

setup_suckless

setup_ssh_key

setup_go

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
