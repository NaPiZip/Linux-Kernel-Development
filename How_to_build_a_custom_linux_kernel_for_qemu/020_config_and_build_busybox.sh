!#/bin/#!/bin/sh

mkdir -pv /obj/busybox-x86
make O=../obj/busybox-x86 defconfig

# Don't forget to sett static lib settings
#-> Busybox Settings
  #-> Build Options
#[ ] Build BusyBox as a static binary (no shared libs)
make O=../obj/busybox-x86 menuconfig

cd /obj/busybox-x86
make -j2
make install
