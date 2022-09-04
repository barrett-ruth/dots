run() {
	echo
	echo "> $*"
	echo
	eval "$*"
}



before() {
run 'timedatectl set-ntp true'


# Partition disk
lsblk
vared -p 'Enter disk to partition: ' -c disk
run "cfdisk /dev/$disk"


# Format partitions
lsblk
vared -p 'Enter root partition suffix: ' -c root
vared -p 'Enter home partition suffix: ' -c home
vared -p 'Enter swap partition suffix: ' -c swap

run "mkfs.ext4 /dev/$disk$root"
run "mkfs.ext4 /dev/$disk$home"
run "mkswap /dev/$disk$swap"


# Mount partitions
run "mount /dev/$disk$root /mnt"
run "mount --mkdir /dev/$disk$home /mnt/home"


# Enable swap volume
run "swapon /dev/$disk$swap"


run 'pacstrap /mnt base linux linux-firmware linux-headers man-db intel-ucode nvidia nvidia-utils xf86-video-intel iwd dhcpcd opendoas git zsh neovim grub efibootmgr os-prober ntfs-3g'


run 'genfstab -U /mnt >> /mnt/etc/fstab'


lsblk


echo
echo '*************************************************************************************'
echo "run 'cd /; mv /root/dots /mnt/home; arch-chroot /mnt; cd /home/dots; zsh install.zsh'"
echo '*************************************************************************************'
echo
}



mid() {
vared -p 'Enter timezone: [Region/city]: ' -c timezone
run "ln -sf '/usr/share/zoneinfo/$timezone' /etc/localtime"


run 'hwclock --systohc'


vared -p 'Enter efi partition suffix: ' -c efi
run "mount --mkdir /dev/$disk$efi /boot/efi"


run "sed -i '/^#en_US.UTF-8 UTF-8/ s/^#*//' /etc/locale.gen"


run "echo 'LANG=en_US.UTF-8' > /etc/locale.conf"


vared -p 'Enter hostname: ' -c hostname
run "echo $hostname > /etc/hostname"


mv misc/hosts /etc/hosts
sed -i "s|{HOST}|$hostname|g" /etc/hosts


run 'passwd'
vared -p 'Enter username: ' -c username
run "useradd -m $username"
run "usermod -aG wheel,storage,power $username"
run "passwd $username"


run 'nvim /etc/doas.conf'


run 'systemctl enable dhcpcd.service'
run 'systemctl start dhcpcd.service'


# Configure grub
run "sed -i '/^#GRUB_DISABLE_OS_PROBER=false/ s/^#*//' /etc/default/grub"
run "sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT/ s/\"$/ ibt=off\"/' /etc/default/grub"
run 'grub-install --target=x86_64-efi --bootloader-id=grub --recheck'
[[ "$(run 'grub-mkconfig -o /boot/grub/grub.cfg' | grep Windows)" ]] || echo ' ***!!! Windows not found in grub install !!!*** '


echo
echo '***************************************************************'
echo "run 'exit; umount -lR /mnt; reboot' and remove the flash drive."
echo '***************************************************************'
echo
}



post() {
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
