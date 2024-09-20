#!/bin/bash
[[ -z $1 ]] && SPKG=${0%/*} || SPKG=$1
RUN='/bin/bash --login'
[[ ! -z $2 ]] && shift && RUN=$@
mount -v --bind /dev $SPKG/dev
mount -v --bind /dev/pts $SPKG/dev/pts
mount -vt proc proc $SPKG/proc
mount -vt sysfs sysfs $SPKG/sys
mount -vt tmpfs tmpfs $SPKG/run
if [ -h $SPKG/dev/shm ]; then
        mkdir -pv $SPKG/$(readlink $SPKG/dev/shm)
fi
[ -e /bin/env ] && ENV=/bin/env || ENV=/usr/bin/env
chroot "$SPKG" $ENV -i                        \
        HOME=/root                                    \
        TERM="$TERM"                                   \
        PS1='(chroot) \u:\w\$ '                         \
        LD_LIBRARY_PATH=/usr/lib:/usr/lib64:/lib:/lib64  \
        PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin \
        SPKG_INSTALL_DIR=$PKG_DB_DIR \
        $RUN
umount -v $SPKG/dev/{pts,}
umount -v $SPKG/{proc,sys,run}