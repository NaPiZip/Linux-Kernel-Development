
<a href="https://www.docker.com">
  <img src="https://stapp.space/content/images/2016/05/docker_header1.png" alt="Docker on Windows logo" style="width:42px;height:42px;">
</a>

# Linux Kernel Development by Robert Love</h1>

<div>
    <a href="https://github.com/NaPiZip/Docker_GUI_Apps_on_Windows">
        <img src="https://img.shields.io/badge/Document%20Version-1.0.0-brightgreen.svg"/>
    </a>
    <a href="https://www.docker.com">
        <img src="https://img.shields.io/badge/Docker-17.05.0--ce-blue.svg"/>
    </a>
    <a href="http://x.cygwin.com">
        <img src="https://img.shields.io/badge/Cygwin%2FX-7.7-blue.svg"/>
    </a>
 </div>
<br/>
<div>    
This is a write down of the book by Robert Love for kernel programming. My goal is not to summarize every chapter and its content. I am mainly doing this write down in order to have a text whit things I find important. It is more like a collection such that I can go back to the most important things.

## Setup
I am using a virtual Linux machine in order to work with the book. I am running a Windows operating system and using a Oracle VM. In order to build the Linux kernel, I installed the following packages using `apt-get`:
```
sudo apt-get update
sudo apt-get install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc bison flex libelf-def
```

<b>Oracle VM tipp</b>
I had trouble using a shared folder with the host OS, the following steps helped me to get the folder mounted in Linux, the solution was found [here](https://askubuntu.com/questions/456400/why-cant-i-access-a-shared-folder-from-within-my-virtualbox-machine).

1. Create a directory in Windows on any location of your choice.
2. In the VirtualBox go to the settings of the Ubuntu Guest.
3. Under the Shared Folder section add the location of you folder created with full permission.
4. Now start the ubuntu guest, and make sure that you have the latest VirtualBox Guest Additions installed.
5. Now add your user to the vboxsf group:
```
sudo usermod -aG vboxsf $(whoami)
```
6. Logout the user and login again.
7. Now you can access your shared directory in `/media/sf_(shared_folder_name)`

## Chapter 2 Getting started with the kernel
This section assumes that the build environment is set up properly and ready for building the kernel.

### Configuring the kernel
I like the variant of the `make menuconfig` for creating a `.config` file. The menu has the benefit of the option to go threw every single setting an read its corresponding explanation. I found this option very helpful at the beginning of the journey. It is also possible to change the `./config` file by hand, it is important to run `make oldconfig` afterwards in order to validate the settings. Here is the workflow:

1. Create the `.config` file with the help of the menu by running:
```
$ make menuconfig
```
2. If needed make manual changes to the `.conf` file.
3. Validate the changes running:
```
$ make oldconfig
```

### Minimizing Build Noise
There are some nice tricks in order to reduce some of the build noise, here are the following options:
- Redirect the output to a file.
```
$ make > build_dumo.txt
```
- Redirect to dev sink.
```
$ make > /dev/null
```

### A Beast of a Different Nature
Here are some important pieces of knowledge with  respect to the Linux kernel:

- The kernel has access to neither the C library nor the standard C headers.
This is mainly related to prevent bloating, but a lot functions are implemented inside the kernel.
- The kernel is coded in GNU C.
The kernel is not programmed in strict ANSI C, this means we need a supported compiler.
- The kernel lacks the memory protection afforded to user-space.
The kernel cannot trap itself easily thus the impacts of a memory corruption are much higher.
- The kernel cannot easily execute floating-point operations.
Unlike user-space, the kernel does not have the luxury of seamless support for floating
point because it cannot easily trap itself.
- The kernel has a small per-process fixed-size stack.
The kernel stack is neither large nor dynamic; it is small and fixed in size. The exact
size of the kernel’s stack varies by architecture.
- Because the kernel has asynchronous interrupts, is preemptive, and supports SMP,
synchronization and concurrency are major concerns within the kernel.
The kernel is very vulnerable to race conditions.
- Portability is important.
This means that architecture-independent C
code must correctly compile and run on a wide range of systems, and that architecture dependent
code must be properly segregated in system-specific directories in the kernel
source tree.

## Chapter 3 Process Management
This section discusses the fundamental elements of a process and a thread within the Linux environment. It describes the lifetime as well as the creation of processes / threads.

### The Process
What is a process? A program itself is not a process; a process is an active program and related resources.
Indeed, two or more processes can exist that are executing the same program. A process is a program in execution, containing a set of resources such as open files and pending signals, internal kernel data, processor state, a memory address space with one or more memory mappings, one or more threads of execution, and a data section containing global variables. 


## Contributing

To get started with contributing to mu GitHub repo, pleas contact me <a href="https://slack.com/">Slack<a/>.
