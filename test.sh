#!/usr/bin/zsh -e
parted -s -a optimal /dev/sda 'mklabel gpt' 'mkpart "EFI system partition" fat32 0% 300MiB' 'mkpart "root partition" btrfs 300MiB 100%' 'set 1 esp on'
mkfs.vfat -F32 /dev/sda1
mkfs.btrfs -f /dev/sda2
mount /dev/sda2 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
unmount /mnt
mount -o rw,noatime,ssd,space_cache=v2,nodatacow,compress=zstd,discard=async subvol=@ /dev/sda2 /mnt
mkdir -p /mnt/boot/
mount /dev/sda1 /mnt/boot/
echo 'END'