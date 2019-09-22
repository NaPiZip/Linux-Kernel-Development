
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

## Setup
Just follow the tutorial form Mitchel, here is a quick overview.
1. Download dependencies.
2. Config and build BusyBox.
  *Note: Do not forget to build as static binary.*
3. Set up `initramfs`.
4. Config and build the Linux kernel.
5. Start QEMU

## Contributing
To get started with contributing to mu GitHub repo, please contact me <a href="https://slack.com/">Slack<a/>.
