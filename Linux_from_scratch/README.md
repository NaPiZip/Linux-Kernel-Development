
<a href="https://www.kernel.org">
  <img src="https://itsfoss.com/wp-content/uploads/2017/12/Linux-Kernel-5-featured.jpg" alt="Linux kernel image" height="42px" width="84px">
</a>

# How to use QEMU for Linux Kernel Hacking</h1>

<div>
    <a href="https://github.com/NaPiZip/Linux-kernel-development">
        <img src="https://img.shields.io/badge/Document%20Version-1.0.0-brightgreen.svg"/>
    </a>
    <a href="https://www.qemu.org/">
        <img src="https://img.shields.io/badge/QEMU-2.11.1-blue"/>
    </a>
    <a href="https://www.busybox.net/">
        <img src="https://img.shields.io/badge/BusyBox-1.31.0-blue"/>
    </a>
    <a href="https://www.kernel.org/">
        <img src="https://img.shields.io/badge/Linux%20Kernel-%20%095.3.1-blue"/>
    </a>
 </div>
<br/>

This is just a quick summary of how to set up QEMU in order to run custom build kernels. This document is based on the tutorial of [Mitchel Humpherys](http://mgalgs.github.io/2015/05/16/how-to-build-a-custom-linux-kernel-for-qemu-2015-edition.html). My intent is not to copy the tutorial of Mitchel, I am just adding things I think are important so I have a centralized documentation for me.

## Tutorial

Continue [here](http://www.linuxfromscratch.org/lfs/view/stable/chapter05/gcc-pass1.html).


<b>How to build binutils 2.25</b>
Link can be found [here](http://www.linuxfromscratch.org/lfs/view/development/chapter06/binutils.html).

<b>How to fix broken packages</b>
In order to fix a broken `binutils`, use the following command.
```
sudo apt-get install --reinstall binutils
```
<b>How to change the version of make to users compiled one</b>
Insert the following line at the end of `~/.bashrc` for bash:
```
export PATH="/usr/local/bin:$PATH"
```
This makes sure that `/user/local/bin` is searched first after all other locations, meaning the users executables will be used first.

<b>How to apply a patch</b>
Here is a brief description on how to apply patches, assuming I have the `.path` or `.diff` file:
1. Inspect the `.patch` file using `cat`.
  ```
  $ cat bzip2-1.0.8-install_docs-1.patch

  diff -Naur bzip2-1.0.4.orig/Makefile bzip2-1.0.4/Makefile
  --- bzip2-1.0.4.orig/Makefile	2007-01-03 03:49:21.000000000 +0000
  +++ bzip2-1.0.4/Makefile	2007-01-26 20:00:01.000000000 +0000
  ```
2. Locate the file referenced in the patch file, here `bzip2-1.0.4/Makefile` and change dir:
  ```
  $ cd ./bzip2-1.0.8
  ```
3. Execute the patch:
  ```
  bzip2-1.0.8$ patch < ../bzip2-1.0.8-install_docs-1.patch
  patching file Makefile
  ```

  Depending on the path, it's sometimes necessary to adjust the path directory wit `-p1`, which omits the first path directory.

## Issues
This section describes all issues I encountered.

<b>Building gcc</b>
I tried to build gcc as described under [5.5.1.](http://www.linuxfromscratch.org/lfs/view/stable/chapter05/gcc-pass1.html), but got the following error message during building:
```
checking for x86_64-lfs-linux-gnu-gcc... /home/nawin/wd/lfs/sources/gcc-9.2.0/build/./gcc/xgcc -B/home/nawin/wd/lfs/sources/gcc-9.2.0/build/./gcc/ -B/tools/x86_64-lfs-linux-gnu/bin/ -B/tools/x86_64-lfs-linux-gnu/lib/ -isystem /tools/x86_64-lfs-linux-gnu/include -isystem /tools/x86_64-lfs-linux-gnu/sys-include   
checking for suffix of object files... configure: error: in `/home/nawin/wd/lfs/sources/gcc-9.2.0/build/x86_64-lfs-linux-gnu/libgcc':
configure: error: cannot compute suffix of object files: cannot compile
See `config.log' for more details
Makefile:12427: recipe for target 'configure-target-libgcc' failed
make[1]: *** [configure-target-libgcc] Error 1
make[1]: Leaving directory '/home/nawin/wd/lfs/sources/gcc-9.2.0/build'
Makefile:939: recipe for target 'all' failed
make: *** [all] Error 2
```

## Decision
I decided to stop this tutorial since the target is only to build Linux from scratch and it does not teach anything. Therefore I am switching to [this](https://embetronicx.com/tutorials/linux/device-drivers/page/3/) tutorial.

## Contributing
To get started with contributing to mu GitHub repo, please contact me <a href="https://slack.com/">Slack<a/>.
