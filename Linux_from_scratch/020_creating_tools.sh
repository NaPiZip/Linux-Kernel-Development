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

cd $LFS/sources
mv -v mpfr-4.0.2 gcc-9.2.0/mpfr
mv -v gmp-6.1.2 gcc-9.2.0/gmp
mv -v mpc-1.1.0 gcc-9.2.0/mpc
