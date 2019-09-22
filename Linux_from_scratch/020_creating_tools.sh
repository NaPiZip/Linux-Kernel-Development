#!/bin/bash
LFS_TGT=$(uname -m)-lfs-linux-gnu
export MAKEFLAGS='-j 2'
ln -sv $LFS/tools /

cd $LFS/sources/binutils-2.32
mkdir build
cd build/

../configure --prefix=/tools            \
             --with-sysroot=$LFS        \
             --with-lib-path=/tools/lib \
             --target=$LFS_TGT          \
             --disable-nls              \
             --disable-werror
