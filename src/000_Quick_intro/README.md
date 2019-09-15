
<a href="https://www.kernel.org">
  <img src="https://itsfoss.com/wp-content/uploads/2017/12/Linux-Kernel-5-featured.jpg" alt="Linux kernel image" height="42px" width="84px">
</a>

# Kernels 101 – Let’s write a Kernel</h1>

<div>
    <a href="https://github.com/NaPiZip/Docker_GUI_Apps_on_Windows">
        <img src="https://img.shields.io/badge/Document%20Version-1.0.0-brightgreen.svg"/>
    </a>
    <a href="https://cdn.kernel.org/pub/linux/kernel/v5.x/">
        <img src="https://img.shields.io/badge/Linux%20Kernel-5.0.0--27--generic-blue"/>
    </a>    
 </div>
<br/>
<div>    
This is a quick write down of the tutorial which can be found (here)[https://arjunsreedharan.org/post/82710718100/kernels-101-lets-write-a-kernel]. The tutorial is pretty good and works with minor issues. I just documented some minor things.

## Issues
After building and installing the kernel image with:
```
$ make all & make install
```
It is necessary to change the configuration of the bootloader, by running the following commands:
```
$ sudo update-grub
Sourcing file `/etc/default/grub'
Generating grub configuration file ...
Found linux image: /boot/kernel-701
Found linux image: /boot/vmlinuz-5.0.0-27-generic
Found initrd image: /boot/initrd.img-5.0.0-27-generic
Found linux image: /boot/vmlinuz-5.0.0-23-generic
Found initrd image: /boot/initrd.img-5.0.0-23-generic
Found memtest86+ image: /boot/memtest86+.elf
Found memtest86+ image: /boot/memtest86+.bin
done
```
This will update the `/boot/grub/grub.cfg` file, after updating change the following entry, from `linux` to `multiboot`, see last line:

```
...
menuentry 'Ubuntu, with Linux 701 (recovery mode)' --class ubuntu --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-701-recovery-b88a0db9-f53d-4e36-9f53-eab8bc9e6d50' {
		recordfail
		load_video
		insmod gzio
		if [ x$grub_platform = xxen ]; then insmod xzio; insmod lzopio; fi
		insmod part_msdos
		insmod ext2
		set root='hd0,msdos1'
		if [ x$feature_platform_search_hint = xy ]; then
		  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,msdos1 --hint-efi=hd0,msdos1 --hint-baremetal=ahci0,msdos1  b88a0db9-f53d-4e36-9f53-eab8bc9e6d50
		else
		  search --no-floppy --fs-uuid --set=root b88a0db9-f53d-4e36-9f53-eab8bc9e6d50
		fi
		echo	'Loading Linux 701 ...'
	        multiboot	/boot/kernel-701 root=/dev/sda1 ro recovery nomodeset
	}
```
## Contributing

To get started with contributing to mu GitHub repo, pleas contact me <a href="https://slack.com/">Slack<a/>.
