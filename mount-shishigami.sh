#!/usr/bin/env bash

green='\033[0;32m'
cyan='\033[0;36m'
nc='\033[0m'

sudo mkdir -p /mnt/shishigami
sudo mkdir -p /mnt/shishigami/media
sudo mkdir -p /mnt/shishigami/misc
sudo mkdir -p /mnt/shishigami/pictures
sudo mkdir -p /mnt/shishigami/portable-hdd

echo -e "${cyan}Mounting shishigami...${nc}"

echo -n 'media: '
sudo mount -t nfs -o vers=4 shishigami:/volume1/media /mnt/shishigami/media
echo -e "${green}OK${nc}"

echo -n 'misc: '
sudo mount -t nfs -o vers=4 shishigami:/volume1/misc /mnt/shishigami/misc
echo -e "${green}OK${nc}"

echo -n 'pictures: '
sudo mount -t nfs -o vers=4 shishigami:/volume1/pictures /mnt/shishigami/pictures
echo -e "${green}OK${nc}"

echo -n 'portable-hdd: '
sudo mount -t nfs -o vers=4 shishigami:/volumeUSB1/usbshare /mnt/shishigami/portable-hdd
echo -e "${green}OK${nc}"
