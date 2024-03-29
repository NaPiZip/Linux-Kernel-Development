#!/bin/bash
mkdir $LFS/tools
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
make && make check && sudo make install

cd $LFS/sources
mv -v gmp-6.1.2 gcc-9.2.0/gmp
mv -v mpfr-4.0.2 gcc-9.2.0/mpfr
mv -v mpc-1.1.0 gcc-9.2.0/mpc
