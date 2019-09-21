!#/bin/#!/bin/sh

mkdir -pv initramfs/x86-busybox
cd initramfs/x86-busybox
mkdir -pv {bin,sbin,etc,proc,sys,usr/{bin,sbin}}
cp -av ../../obj/busybox-x86/_install/* .
cp ../../init .
cmod +x init

# Create arcive file
find . -print0 \
    | cpio --null -ov --format=newc \
    | gzip -9 > ../../obj/initramfs-busybox-x86.cpio.gz
