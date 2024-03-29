
<a href="https://www.kernel.org">
  <img src="https://itsfoss.com/wp-content/uploads/2017/12/Linux-Kernel-5-featured.jpg" alt="Linux kernel image" height="42px" width="84px">
</a>

# Linux Kernel Development by Robert Love</h1>

<div>
    <a href="https://github.com/NaPiZip/Docker_GUI_Apps_on_Windows">
        <img src="https://img.shields.io/badge/Document%20Version-1.0.0-brightgreen.svg"/>
    </a>
    <a href="https://www.docker.com">
        <img src="https://img.shields.io/badge/Docker-17.05.0--ce-blue.svg"/>
    </a>    
 </div>
<br/>
<div>    
This is a write down of the book by Robert Love for kernel programming. My goal is not to summarize every chapter and its content. I am mainly doing this write down in order to have a text whit things I find important. It is more like a collection such that I can go back to the most important things.

## Setup
I am using a virtual Linux machine in order to work with the book. I am running a Windows operating system and using a Oracle VM. In order to build the Linux kernel, I installed the following packages using `apt-get`:
```
sudo apt-get update
sudo apt-get install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc bison flex libelf-dev
```
The full dependency list can be found [here](https://www.kernel.org/doc/html/latest/process/changes.html#changes).

<b>Oracle VM tip</b>
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
7. Now you can access your shared directory in `/media/sf_(shared_folder_name)`.

## Chapter 2 Getting started with the kernel
This section assumes that the build environment is set up properly and ready for building the kernel.

### Configuring the kernel
I like the variant of the `make menuconfig` for creating a `.config` file. The menu has the benefit of the option to go threw every single setting an read its corresponding explanation. I found this option very helpful at the beginning of the journey. It is also possible to change the `./config` file by hand, it is important to run `make oldconfig` afterwards in order to validate the settings. Here is the workflow:

1. Create the `.config` file by copying your local setting:
```
$ cp /boot/config-$(uname -r) .config
```
2. If needed make manual changes to the `.conf` file.
```
$ make menuconfig
```
3. Validate the changes running:
```
$ make oldconfig
```

<b>Build issues</b><br>
For some reason I was not able to build the latest kernel image from Linus Torvalds GitHub repository found [here](https://github.com/torvalds/linux), due to the following error message:
```
$ make -j2
Makefile:608: include/config/auto.conf: No such file or directory
Makefile:660: include/config/auto.conf.cmd: No such file or directory
  HOSTCC  scripts/kconfig/conf.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --syncconfig Kconfig

*** Error during sync of the configuration.

scripts/kconfig/Makefile:73: recipe for target 'syncconfig' failed
make[2]: *** [syncconfig] Error 1
Makefile:562: recipe for target 'syncconfig' failed
make[1]: *** [syncconfig] Error 2
Makefile:678: recipe for target 'include/config/auto.conf.cmd' failed
make: *** [include/config/auto.conf.cmd] Error 2
make: *** Deleting file 'include/config/auto.conf.cmd'
```
The question was posted on Stackoverflow but I couldn't get it up running, see [here](https://stackoverflow.com/questions/57777429/error-building-latest-linux-kernel-within-virtualbox-under-18-04-1-ubuntu). This is why I decided to move on with an actual official kernel release instead of using the development branch. The source can be found here [cdn.kernel.org](http://cdn.kernel.org/pub/linux/kernel/v5.x/). Turns out that the `linux-5.2.9.tar.gz` kernel builds out of the box following the process from above.

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

<p align="center">
<img src="https://raw.githubusercontent.com/NaPiZip/Linux-kernel-development/master/Robert_love/images/Forking%20and%20waiting.JPG" alt="Forking and waiting"/></p>

### Threads
Threads on the other hand are objects within the process, Each thread includes a unique program counter (PC), process stack and a set of processor register. The kernel schedules threads not processes! In Linux a Thread is just a special variation of a process, it's kin of a light version.

### Process Descriptor, the Task Structure and allocation
The kernel stores the list of processes in a circular doubly linked list called the task list. The process descriptor contains all the information about
a specific process. The struct `thread_info`, lives at the bottom of the stack and points to a `task_struct`, which is part of the task list.

<p align="center">
<img src="https://raw.githubusercontent.com/NaPiZip/Linux-kernel-development/master/Robert_love/images/Process%20kernel%20stack.JPG" alt="Process Kernel Stack" height="50%" width="50%"/></p>

### The Process Family Tree
All processes are descendants of the init process, whose PID is one. The kernel starts init in the last step of the boot process. The init process, in turn, reads the system initscripts and executes more programs, eventually completing the boot process.

### Process Creation
Most operating systems implement a spawn mechanism to create a new process in a new address space, read in an executable, and begin executing it. Unix takes the unusual approach of separating these steps into two distinct functions: fork()and exec(). `fork()` creates a child process and `exec()` loads a new
executable into the address space and begins executing it. Traditionally, upon fork(), all resources owned by the parent are duplicated and the copy is given to the child. In Linux, fork() is implemented through the use of copy-on-write pages. Copy-on-write (or COW) is a technique to prevent duplicate the process
address space, the parent and the child can share a single copy.
The data, however, is marked in such a way that if it is written to, a duplicate is made and each process receives a unique copy. Consequently, the duplication of resources occurs only when they are written; until then, they are shared read-only.

### The Linux Implementation of Threads
Linux implements all threads as standard processes. A thread is merely a process that shares certain resources with other processes. Each thread has a unique `task_struct` and appears to the kernel as a normal process. For other operating systems, threads
are an abstraction to provide a lighter, quicker execution unit than the heavy process.

### Kernel Threads
It is often useful for the kernel to perform some operations in the background. The kernel accomplishes this via kernel threads, kernel threads do not have an address space.

## Chapter 4  Process Scheduling
The process scheduler decides which process runs, when, and for how long. The idea behind the scheduler is simple. To best utilize processor time, assuming there are runnable processes, a process should always be running.

###  Multitasking
A multitasking operating system is one that can simultaneously interleave execution of more than one process. Consequently, a modern Linux system can have many processes in memory but, say, only one in a runnable state. Multitasking operating systems come in two flavors: cooperative multitasking and preemptive multitasking.<br>
- Preemptive multitasking
In preemptive multitasking, the scheduler decides when a process is to cease running and a new process is to begin running. The act of involuntarily suspending a running process is called preemption.
- Cooperative multitasking
A process does not stop running until it voluntary
decides to do so. The act of a process voluntarily suspending itself is called yielding.

### Linux’s Process Scheduler
O(1) scheduler introduced a constant-time algorithm for timeslice calculation and per-processor runqueues. The O(1) scheduler was ideal
for large server workloads—which lack interactive processes—it performed below par on desktop systems.



### I/O-Bound Versus Processor-Bound Processes
I/O-bound is a process that spends much of its time submitting and waiting on Io requests. By I/O, we mean any type of blockable resource, such as keyboard input or network I/O, and not just disk I/O. Processor-bound processes spend much of their time executing code, the ultimate example of a processor-bound process is one executing an infinite loop.

### Process Priority
The goal is to rank processes based on their worth and need for processor time. The general idea is that  a processes with a higher priority run before those with a lower priority, whereas processes with the same priority are scheduled round-robin (one after the next, repeating). The Linux kernel implements two separate priority ranges.
- The nice value
–20 to +19 with a default of 0, larger nice values correspond to a lower priority, means you are being nice.
- The real-time priority
0 to 99, inclusive, higher real-time priority values correspond to a greater priority.

### Timeslice
Represents the numeric value on how ling a task can run without interruption. The scheduler policy defines a default Timeslice. A too long timeslice causes the system to have poor interactive performance. To short causes a lot of time being wasted on context switching of the processor.

## Contributing
To get started with contributing to mu GitHub repo, please contact me <a href="https://slack.com/">Slack<a/>.
