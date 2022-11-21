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


before() {
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

run "sed -i '/^#ParallelDownloads/ s|^#*||' /etc/pacman.conf"

run 'pacstrap -K /mnt base linux-lts linux-firmware linux-lts-headers intel-ucode nvidia-lts nvidia-utils reflector \
    clang dhcpcd docker docker-compose fakeroot fd gcc git iwd light make opendoas openssh patch pkgconf python ripgrep which xclip \
    cmake ninja unzip \
    ttf-hanazono ttf-liberation ttf-jetbrains-mono \
    zsh zsh-syntax-highlighting zsh-completions \
    grub efibootmgr os-prober ntfs-3g \
    xorg-server xorg-setxkbmap xorg-xinit xorg-xmodmap xorg-xrandr xorg-xrdb xorg-xset \
    libxft libxinerama
    dash exa feh harfbuzz man-db man-pages postgresql tmux yarn \
    selene shfmt lua stylua tidy tree-sitter lua-language-server \
    imagemagick \
    jq mpv pulseaudio rsync socat transmission-cli'

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
# sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT/ s|"$| ibt=off nvidia_drm.modeset=1"|' /etc/default/grub
sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT/ s|"$| nvidia-drm.modeset=1"|' /etc/default/grub
# sed -i '/^GRUB_TIMEOUT/ s|.$|-1|' /etc/default/grub
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
# run 'mv dots/misc/10-nvidia-drm-outputclass.conf /etc/X11/xorg.conf.d'
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
sed -i '/#*IdentityFile/ s|.ssh|.config/ssh|g' /etc/ssh/ssh_config
sed -i '/#*IdentityFile/ s|^#*||g' /etc/ssh/ssh_config
sed -i '/#*AuthorizedKeysFile/ s|.ssh|.config/ssh|g' /etc/ssh/sshd_config
sed -i '/#*AuthorizedKeysFile/ s|^#*||g' /etc/ssh/sshd_config
}


setup_pacman() {
sed -i '/^#HookDir/ s|^#*||' /etc/pacman.conf
sed -i '/^#ParallelDownloads/ s|^#*||' /etc/pacman.conf
run 'mv dots/misc/dash.hook /etc/pacman.d/hooks'
run 'mv dots/misc/reflector.conf /etc/xdg/reflector/'
run 'pacman -S bash'
}


mid() {
setup_time

setup_locale

vared -p 'Enter username: ' -c username
setup_users "$username"

setup_doas "$username"

setup_pacman

run 'systemctl enable dhcpcd'
run 'systemctl enable sshd'
run 'systemctl enable postgresql'
run 'systemctl enable fstrim.timer'
run 'systemctl enable reflector.timer'
run 'systemctl enable iwd'

run 'mv dots/misc/zshenv /etc/zsh'

setup_grub

setup_nvidia

setup_X11

setup_transmission

setup_ssh_etc

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
run 'mkdir fd; ln -s git/ignore fd/ignore'
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

virtualenv venv
. venv/bin/activate
pip install neovim
deactivate
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
cd dev
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
for i in 'clipmenu-git' 'shellcheck-bin' 'hadolint-bin' 'sioyek-git' 'sqls-bin' 'ungoogled-chromium-xdg-bin' 'neovim-nightly-bin'; do
    git clone https://aur.archlinux.org/"$i".git
    cd "$i"
    if [[ "$i" == 'clipmenu-git' ]]; then
        sed -i '/^depends*/ s|dmenu ||' PKGBUILD
    fi
    makepkg -si
    cd ..
    rm -rf "$i"
done

run 'git clone https://github.com/barrett-ruth/wp.git'
cd wp
git remote set-url origin git@github.com:barrett-ruth/wp.git
cd ..

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
# extensions: wikiwand, ublockorigin, react devtools, vimium c, clear new tab (background rgb(69, 87, 96, 1)), google translate, numbered-tabs
#}


setup_pip() {
python -m ensurepip
pip3 install black curlylint djlint flake8 isort jedi-language-server mypy virtualenv yamllint
}


setup_yarn() {
yarn --use-yarnrc ~/.config/yarn/config global add prettier @tailwindcss/language-server eslint_d neovim prettier pyright typescript typescript-language-server ts-node @types/node vim-language-server vscode-langservers-extracted sql-formatter markdownlint markdownlint-cli
rm "$HOME/.yarnrc"
}


setup_dirs() {
mkdir -p doc dl mus .local/bin .local/share/nvim .config/ssh
}


post() {
# no xf86-video-intel for now
run 'mandb'

run 'doas usermod -aG docker,video "$(whoami)"'

# Rebuild grub config to recognize Windows Boot Manager
run 'doas grub-mkconfig -o /boot/grub/grub.cfg'

setup_dirs

setup_misc_configs

setup_misc_packages

setup_neovim

setup_postgres

chsh -s "$(which zsh)"

setup_fzf

setup_suckless

setup_ssh_key

setup_yarn

setup_pip

# Cleanup
run 'rm -rf .bash* .cache .lesshst dots'
run 'pacman -Rs $(pacman -Qtdq)'

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
