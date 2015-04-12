#!/bin/bash +x

pushd build
MACHINE=xenclient-dom0 ./bb -c cleanall audio-helper
MACHINE=xenclient-dom0 ./bb audio-helper
popd

if [ "$#" -eq 2 ]; then
    scp /home/user/openxt/builds/qemu14/build/tmp-eglibc/work/core2-oe-linux/audio-helper-0+git$2*/image/usr/lib/xen/bin/audio_helper root@$1:/usr/lib/xen/bin/audio_helper
    scp /home/user/openxt/builds/qemu14/build/tmp-eglibc/work/core2-oe-linux/audio-helper-0+git$2*/image/usr/lib/xen/bin/audio_helper_start root@$1:/usr/lib/xen/bin/audio_helper_start
fi
