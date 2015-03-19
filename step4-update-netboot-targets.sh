#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: ./step2-create-source-tree <tree name> <ip address>"
    exit 1
fi

if [ "$(id -u)" == "0" ]; then
   echo "This script must be run as a normal user" 1>&2
   exit 1
fi

echo Patching pxelinux.cfg
sudo sed -i "s/@TFTP_PATH@/.\/builds\/$1\/build-output\/openxt-dev--master\/netboot/g" ~/openxt/builds/$1/build-output/openxt-dev--master/netboot/pxelinux.cfg
sudo sed -i "s/dhcp/$2/g" ~/openxt/builds/$1/build-output/openxt-dev--master/netboot/pxelinux.cfg

echo Patching answer files
sudo sed -i "s/@NETBOOT_URL@/http:\/\/$2\/$1\//g" ~/openxt/builds/$1/build-output/openxt-dev--master/netboot/network.ans
sudo sed -i "s/@NETBOOT_URL@/http:\/\/$2\/$1\//g" ~/openxt/builds/$1/build-output/openxt-dev--master/netboot/network_download_win.ans
sudo sed -i "s/@NETBOOT_URL@/http:\/\/$2\/$1\//g" ~/openxt/builds/$1/build-output/openxt-dev--master/netboot/network_manual.ans
sudo sed -i "s/@NETBOOT_URL@/http:\/\/$2\/$1\//g" ~/openxt/builds/$1/build-output/openxt-dev--master/netboot/network_manual_download_win.ans
sudo sed -i "s/@NETBOOT_URL@/http:\/\/$2\/$1\//g" ~/openxt/builds/$1/build-output/openxt-dev--master/netboot/network_upgrade.ans

sudo /etc/init.d/tftpd-hpa stop
sudo /etc/init.d/tftpd-hpa start
