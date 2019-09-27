#!/bin/bash

cd $LFS/sources/glibc-2.30

sed -i '/asm.socket.h/a# include <linux/sockios.h>' \
   sysdeps/unix/sysv/linux/bits/socket.h

case $(uname -m) in
   i?86)   ln -sfv ld-linux.so.2 /lib/ld-lsb.so.3
   ;;
   x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 /lib64
           ln -sfv ../lib/ld-linux-x86-64.so.2 /lib64/ld-lsb-x86-64.so.3
   ;;
esac

# No clue why this is diffrent from online, the commands above.
mkdir -v build
cd       build

../configure --prefix=/tools \
             --host=$LFS_TGT \
             --build=$(../scripts/config.guess) \
             --enable-kernel=3.2 \
             --with-headers=/tools/include \
             --lib_cv_ctors_headers=yes
