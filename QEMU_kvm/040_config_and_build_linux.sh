!#/bin/#!/bin/sh

cd linux-5.3.1
make O=../obj/linux-x86-basic x86_64_defconfig
make O=../obj/linux-x86-basic kvmconfig
make O=../obj/linux-x86-basic -j2
