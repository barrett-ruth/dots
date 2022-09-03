vared -p 'before, mid, or post install? [b/m/p]' -c status
case "$status" in
b)
	before
	;;
m)
	mid
	;;
p)
	post
	;;
*)
	exit
	;;
esac



run() {
	echo "> $*"
	eval "$*"
}



before() {
run 'timedatectl set-ntp true'


# Partition disk
lsblk
vared -p 'Enter disk to partition: ' -c disk
run "cfdisk /dev/$disk"


# Format partitions
vared -p 'Enter root partition suffix: ' -c root
vared -p 'Enter home partition suffix: ' -c home
vared -p 'Enter swap partition suffix: ' -c swap

run "mkfs.ext4 /dev/$disk$root"
run "mkfs.ext4 /dev/$disk$home"
run "mkswap /dev/$disk$swap"


# Mount partitions
vared -p 'Enter efi partition suffix: ' -c efi
run "mount --mkdir /dev/$disk$efi /mnt/boot/efi"
run "mount /dev/$disk$root /mnt"
run "mount --mkdir /dev/$disk$home /mnt/home"


# Enable swap volume
run "swapon /dev/$disk$swap"


run 'pacstrap /mnt base linux linux-firmware linux-headers man-db intel-ucode nvidia nvidia-utils xf86-video-intel iwd dhcpcd opendoas grub efibootmgr os-prober ntfs-3g'


run 'genfstab -U /mnt >> /mnt/etc/fstab'


echo '***********************************************************************************'
echo "run 'arch-chroot /mnt; mv /root/dots /mnt/home; cd /mnt/home/dots; zsh install.zsh'"
echo '***********************************************************************************'
}



mid() {
pacman -Rs vim

vared -p 'Enter timezone: [Region/city]: ' -c timezone
run "ln -sf /usr/share/zoneinfo/$timezone /etc/localtime"


run 'hwclock --systohc'


run "sed -i '/^#en_US.UTF-8 UTF-8/ s/^#*//' /etc/locale.gen"


run "echo 'LANG=en_US.UTF-8' > /etc/locale.conf"


vared -p 'Enter hostname: ' -c hostname
run "echo $hostname > /etc/hostname"


mv misc/hosts /etc/hosts
sed -i "s|{HOST}|$hostname|g" /etc/hosts


run 'vim /etc/doas.conf'


run 'passwd'
vared -p 'Enter username: ' -c username
run "useradd -m $username"
run "usermod -aG wheel,storage,power $username"


run 'systemctl enable dhcpcd.service'
run 'systemctl start dhcpcd.service'


# Configure grub
run "sed -i '/^#GRUB_DISABLE_OS_PROBER=false/ s/^#*//' /etc/default/grub"
run 'grub-install --target=x86_64-efi --bootloader-id=grub --recheck'
run 'grub-mkconfig -o /boot/grub/grub.cfg'


echo '*********************************************************'
echo "run 'umount -lR /mnt; reboot' and remove the flash drive."
echo '*********************************************************'
}



post() {
}
