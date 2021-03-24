#!/bin/sh -e
loadkeys ru
setfont cyr-sun16
echo 'Скрипт сделан на основе чеклиста Бойко Алексея по Установке ArchLinux'
echo 'Ссылка на чек лист есть в группе vk.com/arch4u'
 
echo '2.3 Синхронизация системных часов'
timedatectl set-ntp true
 
echo '2.4 создание разделов'
(
 echo g;
 
 echo n;
 echo ;
 echo;
 echo +300M;
 echo y;
 echo t;
 echo 1;
 
 echo n;
 echo;
 echo;
 echo;
 echo y;

 echo w;
) | fdisk /dev/sda

echo 'Ваша разметка диска'
fdisk -l

echo 'format'
mkfs.vfat -F32 /dev/sda1
mkfs.btrfs -f /dev/sda2
mount /dev/sda2 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
unmount /mnt
mount -o rw,noatime,ssd,space_cache=v2,nodatacow,compress=zstd,discard=async subvol=@ /dev/sda2 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi

echo 'END'