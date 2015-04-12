#!/bin/bash +x

pushd build
MACHINE=xenclient-stubdomain ./bb -c cleanall qemu-dm-stubdom
MACHINE=xenclient-stubdomain ./bb -c cleanall xenclient-stubdomain-initramfs-image
popd
./do_build.sh -s stubinitramfs

if [ "$#" -eq 1 ]; then
    scp ./build/tmp-eglibc/deploy/images/xenclient-stubdomain-initramfs-image-xenclient-stubdomain.cpio.gz root@$1:/usr/lib/xen/boot/stubdomain-initramfs
fi
