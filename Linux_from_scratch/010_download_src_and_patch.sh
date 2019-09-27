#!/bin/bash

SCRIPT_DIR=${PWD}

mkdir -vp $LFS/sources

# Get the sources
curl http://www.linuxfromscratch.org/lfs/view/stable/wget-list | xargs wget --directory-prefix=$LFS/sources
# Get the patches
wget --input-file=patch-list --continue --directory-prefix=$LFS/sources

curl http://www.linuxfromscratch.org/lfs/view/stable/md5sums > md5sums

pushd $LFS/sources
md5sum -c $LFS/md5sums
md5sum -c $SCRIPT_DIR/patch-list-md5sums
popd

ls | grep .tar | xargs -i tar xf {}

pushd $LFS/sources/sysvinit-2.95
echo "Patching sysvinit-2.95"
patch -p1 < ../sysvinit-2.95-consolidated-1.patch
cd ../kbd-2.2.0
echo "Patching kbd-2.2.0"
patch -p1 < ../kbd-2.2.0-backspace-1.patch
echo "Patching glibc-2.30"
cd ../glibc-2.30
patch -p1 < ../glibc-2.30-fhs-1.patch
echo "Patching coreutils-8.31"
cd ../coreutils-8.31
patch -p1 < ../coreutils-8.31-i18n-1.patch
echo "Patching glibc-2.30"
cd ../glibc-2.30
patch -p1 < ../bzip2-1.0.8-install_docs-1.patch
popd
