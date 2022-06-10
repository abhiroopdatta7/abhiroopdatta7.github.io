# Creating Guest VMs
Before creating the guest VM, we need to ensure the Guest OS is supported by the KVM, can check by running the 

following command :
```bash
osinfo-query os
```

## Installation
```bash
sudo apt-get install -y virtinst
```

## Create a Guest VM   
```bash
sudo virt-install \
        --name vm1 \
        --os-type linux \
        --os-variant ubuntu20.04 \
        --ram=4096 \
        --vcpus 4 \
        --disk path=/home/vhd/vm1.qcow2,bus=virtio,size=5 \
        --cdrom=/home/osmedia/ubuntu-20.04.3-live-server-amd64.iso \
        --check all=off \
        --graphics vnc,listen=0.0.0.0 \
        --network type=direct,source=eno1,source_mode=bridge,model=virtio
```

## The virt-install command options

This topic describes the options that are available from the virt-install command when creating a KVM virtual machine image.

### Required options

The minimum required options when using the virt-install command to create a KVM virtual machine image are --name, --ram, guest storage (--disk or --nodisks), and an installation option. These parameters are described in the following sections.

### General options

#### --connect=CONNECT
Connect to a non-default hypervisor. The default connection is chosen based on the following rules:

- xen: If running on a host with the Xen kernel (checks against /proc/xen)

- qemu:///system: If running on a bare metal kernel as root

- qemu:///session: If running on a bare metal kernel as non-root

It is only necessary to provide the --connect argument if this default prioritization is incorrect, for example, if you want to use QEMU while on a Xen kernel.

#### -n NAME , --name=NAME
Name of the new guest virtual machine instance. This name must be unique among all guests known to the hypervisor on this system, including those guests that not currently active. This parameter is for if omitted on the command line.

#### -r MEMORY , --ram=MEMORY

Memory to allocate for guest instance in megabytes. If the hypervisor does not have enough free memory, it automatically takes memory away from the host operating system to satisfy this allocation. This parameter is prompted for if omitted on the command line.

#### --arch=ARCH

Request a non-native processor architecture for the guest virtual machine. The option is only currently available with QEMU guests, and does not enable use of acceleration. If omitted, the host processor architecture is used in the guest.

#### -u UUID , --uuid=UUID

UUID for the guest; if none is given a random UUID is generated. If you specify UUID, use a 32-digit hexadecimal number. If you are manually specifying an UUID, remember that UUID are intended to be unique across the entire data center, and indeed world.

#### --vcpus=VCPUS

Number of virtual processors to configure for the guest. Not all hypervisors support SMP guests, in which case this argument is silently ignored.

#### --cpuset=CPUSET

Set which physical processor that the guest can use. CPUSET is a comma-separated list of numbers or a range of numbers separated by commas. For example, 0,2,3,5: Use processors 0,2,3 and 5 1-3,5,6-8: Use processors 1,2,3,5,6,7 and 8

#### --description

Human readable text description of the virtual machine. This description is stored in the guests XML configuration for access by other applications.

#### --security type=TYPE[,label=LABEL]

Configure domain security driver settings. The TYPE parameter can be either static or dynamic. If you chose static, you must use a security LABEL. Specifying LABEL without TYPE implies static configuration.

### Installation options

#### -l LOCATION , --location=LOCATION

Specifies the installation source for guest virtual machine kernel+initrd pair. The LOCATION parameter can take one of the following forms:

-   DIRECTORY - Path to a local directory containing an installable distribution image
-   nfs:host:/path or nfs://host/path - An NFS server location containing an installable distribution image
-   [http://host/path](http://host/path) - An HTTP server location containing an installable distribution image
-   [ftp://host/path](ftp://host/path) - An FTP server location containing an installable distribution image

#### -c CDROM , --cdrom=CDROM

File or device to use a virtual CD-ROM device for fully virtualized guests. It can be path to an ISO image, or to a CD-ROM device. It can also be a URL from which to fetch/access a minimal boot ISO image. The URLs take the same format as described for the --location argument. If a CD-ROM device has been specified by the --disk option, and neither --cdrom nor any other installation option is specified, the --disk CD-ROM device is used as the installation media. If this parameter is omitted then the --location argument must be given to specify a location for the kernel and initrd, or the --pxe argument used to install from the network.

#### --pxe

Use the PXE boot protocol to load the initial ramdisk and kernel for starting the guest installation process. If this parameter is omitted then either the --location or --cdrom arguments must be given to specify a location for the kernel and initrd.

#### --livecd

Specify that the installation media is a live CD and thus the guest must be configured to boot off the CD-ROM device permanently. Consider using the --nodisks flag in combination.

#### --import

Skip the OS installation process, and build a guest around an existing disk image. The device used for booting is the first device specified by --disk or --file.

#### --os-type=OS_TYPE

Optimize the guest configuration for a type of operating system. This option picks the most suitable ACPI and APIC settings, optimally supported mouse drivers, and other recommended operating system settings. The valid operating system types are:

1.  linux - Linux 2.x series
2.  windows - Microsoft Windows 9x or later
3.  unix - Traditional UNIX BSD or SysV derivatives
4.  other - Operating systems not in one of the three prior groups

#### --os-variant=OS_VARIANT

Further optimize the guest configuration for a specific operating system variant. This parameter is optional. The valid variants are:

Linux

-   rhel2.1 Red Hat Enterprise Linux 2.1
-   rhel3 Red Hat Enterprise Linux 3
-   rhel4 Red Hat Enterprise Linux 4
-   rhel5 Red Hat Enterprise Linux 5
-   centos5 Cent OS 5
-   fedora5 Fedora Core 5
-   fedora6 Fedora Core 6
-   fedora7 Fedora 7
-   sles10 Suse Linux Enterprise Server 10.x
-   debianEtch Debian 4.0 (Etch)
-   debianLenny Debian Lenny
-   generic26 Generic Linux 2.6.x kernel
-   generic24 Generic Linux 2.4.x kernel

windows

-   winxp Microsoft Windows XP Professional
-   win2k Microsoft Windows 2000
-   win2k3 Microsoft Windows 2003
-   vista Microsoft Windows Vista

unix

-   solaris9 Sun Solaris 9
-   solaris10 Sun Solaris 10
-   freebsd6 Free BSD 6.x
-   openbsd4 Open BSD 4.x

other

-   msdos Microsoft DOS
-   netware4 Novell Netware 4
-   netware5 Novell Netware 5
-   netware6 Novell Netware 6

#### -x EXTRA , --extra-args=EXTRA

Additional kernel command-line arguments to pass to the installer when performing a guest installation from a kernel+initrd.

### Storage options

#### --disk=DISKOPTS

Specifies media to use as storage for the guest, with various options. The general format of a disk string is: --disk opt1=val1,opt2=val2,.... To specify media, the command format can either be: --disk /some/storage/path,opt1=val1 or explicitly specify one of the following arguments:

##### path

A path to some storage media to use, existing or not. Existing media can be a file or block device. If installing on a remote host, the existing media must be shared as a libvirt storage volume. Specifying a non-existent path implies creating the storage, and requires that you specify a size value. If the base directory of the path is a libvirt storage pool on the host, the new storage is created as a libvirt storage volume. For remote hosts, the base directory is required to be a storage pool if using this method.

##### pool

An existing libvirt storage pool name on which to create new storage. This option requires that you specify a size value.

##### vol

An existing libvirt storage volume to use. This value is specified as poolname/volname.

Other available options:

##### device

Disk device type. Value can be cdrom, disk, or floppy. Default is disk. If a cdrom is specified, and no installation method is chosen, the CD-ROM device is used as the installation media.

##### bus

Disk bus type. Value can be ide, scsi, usb, virtio, or xen. The default is hypervisor-dependent because not all hypervisors support all bus types.

##### perms

Disk permissions. Value can be rw (read/write), ro (Read-only), or sh (Shared read/write). Default is rw.

##### size

Size (in GB) to use if creating new storage

##### sparse

Whether to skip fully allocating newly created storage. Value is true or false. Default is true (do not fully allocate). The initial time taken to fully allocate the guest virtual disk (spare=false) is usually by balanced by faster installation times inside the guest. For that reason, use this option in order to ensure consistently high performance and to avoid I/O errors in the guest should the host file system run out of space.

##### cache

The cache mode to be used. The host pagecache provides cache memory. The cache value can be none, writethrough, or writeback. The writethrough option provides read caching. The writeback option provides read and write caching.

##### format

Image format to be used if creating managed storage. For file volumes, this value can be one of the following values:

-   raw: a plain file
-   bochs: Bochs disk image format
-   cloop: compressed loopback disk image format
-   cow: User Mode Linux disk image format
-   dmg: Mac disk image format
-   iso: CDROM disk image format
-   qcow: QEMU v1 disk image format
-   qcow2: QEMU v2 disk image format
-   vmdk: VMWare disk image format
-   vpc: VirtualPC disk image format

This option deprecates --file, --file-size, and, --nonsparse.

#### --nodisks

Request a virtual machine without any local disk storage, typically used for running 'Live CD' images or installing to network storage (iSCSI or NFS root). This parameter disables all interactive prompts for disk setup.

#### --nonsparse

This option is deprecated in favor of --disk ...,sparse=false,...

#### -f DISKFILE, --file=DISKFILE

This option is deprecated in favor of --disk path=DISKFILE.

#### -s DISKSIZE, --file-size=DISKSIZE

This option is deprecated in favor of --disk ...,size=DISKSIZE,...

### Network options

#### --network=NETWORK

Connect the guest to the host network. The value for NETWORK can take one of three formats:

##### bridge=BRIDGE

Connect to a bridge device in the host called BRIDGE. Use this option if the host has static networking configuration and the guest requires full outbound and inbound connectivity to and from the LAN. Also use this option if the guest will use live migration.

##### network:NAME

Connect to a virtual network in the host called NAME. Virtual networks can be listed, created, deleted using the virsh command-line tool. In an unmodified installation of libvirt there is usually a virtual network with a name of default. Use a virtual network if the host has dynamic networking (for example, Network Manager), or is using wireless. The guest is connected to the LAN using Network Address Translation (NAT) by whichever connection is active.

##### user

Connect to the LAN using SLIRP. Use this option only if you are running a QEMU guest as an unprivileged user. This option provides a limited form of NAT.

If this option is omitted, a single NIC is created in the guest. If there is a bridge device in the host with a physical interface enslaved, that is used for connectivity. Failing that, the default virtual network is used. This option can be specified multiple times to set up more than one NIC.

Other available options are:

##### model

Network device model as seen by the guest. Value can be any network device model supported by the hypervisor, for example: e1000, rtl8139, or virtio.

##### mac

Fixed MAC address for the guest. If this parameter is omitted, or the value RANDOM is specified a suitable address is randomly generated. For Xen virtual machines it is required that the first three pairs in the MAC address is the sequence 00:16:3e, while for QEMU or KVM virtual machines it must be 52:54:00.

##### --nonetworks

Request a virtual machine without any network interfaces.

##### -m MAC , --mac=MAC

This parameter is deprecated in favor of --network NETWORK,mac=12:34...

##### -b BRIDGE , --bridge=BRIDGE

This parameter is deprecated in favor of the --network bridge=bridge_name

### Graphics options

If you do not specify a graphics option, the virt-install tool defaults to --vnc if the DISPLAY environment variable is set, otherwise --nographics is used.

#### --vnc

Set up a virtual console in the guest and export it as a VNC server in the host. Unless the --vncport parameter is also provided, the VNC server runs on the first free port number at 5900 or above. The actual VNC display allocated can be obtained using the vncdisplay command to the virsh command. If you do not specify the --vnc, --sdl, or --nographics parameter, you are prompted.

#### --vncport=VNCPORT

Request a permanent, statically assigned port number for the guest VNC console. Using this option may cause other guests to clash if they are using the same port.

#### --vnclisten=VNCLISTEN

Address to listen on for VNC connections. Default is typically 127.0.0.1 (localhost only), but you can change this value globally in some hypervisors; for example, the QEMU driver default can be changed in /etc/libvirt/qemu.conf. Use 0.0.0.0 to provide access from other machines.

#### -k KEYMAP , --keymap=KEYMAP

Request that the virtual console is configured to run with a non-English keyboard layout.

#### --sdl

Set up a virtual console in the guest and provide an SDL window in the host to render the information that is returned. If the SDL window is closed the guest may be unconditionally terminated.

#### --nographics

Disable all interactive prompts for the guest virtual console. No graphical console is allocated for the guest. A text-based console is always available on the first serial port.

#### --noautoconsole

Do not automatically try to connect to the guest console. The default behavior is to open a VNC client to display the graphical console, or to run the virsh console command to display the text console. Using this parameter disables the default behavior.

### Virtualization type options

#### -v, --hvm

This guest is a fully virtualized guest. Request the use of full virtualization, if both para & full virtualization are available on the host. This parameter is implied if connecting to a QEMU-based hypervisor.

#### --noapic

Override the OS type and variant to disable the APIC setting for fully virtualized guest.

#### --noacpi

Override the OS type and variant to disable the ACPI setting for fully virtualized guest.

#### -p, --paravirt

This guest is a paravirtualized guest. If the host supports both paravirtualization and full virtualization, and you do not specify this parameter nor the --hvm parameter, this parameter is prompted for interactively.

#### --accelerate

When installing a QEMU guest, use the KVM or KQEMU kernel acceleration capabilities if available. Use this option, unless a guest operating system is known to be incompatible with the accelerators. The KVM accelerator is preferred over KQEMU if both are available.

#### –virt-type

The hypervisor on which to install the guest. Choices are kvm, qemu, xen, or kqemu.

### Device options

#### --host-device=HOSTDEV

Attach a physical host device to the guest. Some example values for the HOSTDEV parameter:

-   --host-device pci_0000_00_1b_0 A node device name from libvirt, as shown by virsh nodedev-list
-   --host-device 001.003 USB by bus, device from the lsusb utility.
-   --host-device 0x1234:0x5678 USB by vendor, product from the lsusb utility.
-   --host-device 1f.01.02 PCI device from the lspci utility.

#### --soundhw MODEL

Attach a virtual audio device to the guest. The MODEL parameter specifies the emulated sound card model. Possible values are ac97, es1370, sb16, pcspk, or default. The default value is AC97 if the hypervisor supports it, otherwise it is set to ES1370.

This parameter deprecates the boolean --sound model parameter, which works the same as a single --soundhw default.

#### --watchdog MODEL[,action=ACTION]

Attach a virtual hardware watchdog device to the guest. This option requires a daemon and device driver in the guest. The watchdog fires a signal when the virtual machine appears to hung. The ACTION parameter specifies what libvirt does when the watchdog fires. Values are:

reset

Forcefully reset the guest (the default)

poweroff

Forcefully power off the guest

pause

Pause the guest

none

Do nothing

shutdown

Gracefully shut down the guest. This option is not recommended, because a hung guest probably will not respond to a graceful shutdown)

The MODEL parameter is the emulated device model: either i6300esb (the default) or ib700. Some examples:

Use the default settings:

#### --watchdog default

Use the sound card model i6300esb with the power-off action

#### --watchdog i6300esb,action=poweroff

#### --parallel=CHAROPTS

#### --serial=CHAROPTS

Specifies a serial device to attach to the guest, with various options. The general format of a serial string is --serial type,opt1=val1,opt2=val2,...

The --serial and --parallel devices share all the same options, unless otherwise noted. Some of the types of character device redirection are:

#### --serial pty

Pseudo TTY. The allocated pty is listed in the running guests XML description.

#### --serial dev,path=HOSTPATH

Host device. For serial devices, this option might be /dev/ttyS0. For parallel devices, this option might be /dev/parport0.

#### --serial file,path=FILENAME

Write output to FILENAME.

#### --serial pipe,path=PIPEPATH

Named pipe

#### --serial tcp,host=HOST:PORT,mode=MODE,protocol=PROTOCOL

TCP net console. The MODE parameter is either bind (wait for connections on HOST:PORT) or connect (send output to HOST:PORT); the default is connect. The HOST parameter defaults to 127.0.0.1, but the PORT parameter is required. The PROTOCOL parameter can be either raw or telnet (default raw). If the telnet parameter, the port acts like a Telnet server or client. Some examples:

Connect to localhost, port 1234:

#### --serial tcp,host=:1234

Wait for connections on any address, port 4567:

#### --serial tcp,host=0.0.0.0:4567,mode=bind

Wait for Telnet connection on localhost, port 2222. You can then connect interactively to this console by using telnet localhost 2222:

#### --serial tcp,host=:2222,mode=bind,protocol=telnet

#### --serial udp,host=CONNECT_HOST:PORT,bind_port=BIND_HOST:BIND_PORT

UDP net console. The HOST:PORT parameter is the destination to send output to. The default HOST value is 127.0.0.1 and the PORT parameter is required. The BIND_HOST:PORT parameter is the optional local address to bind to. The default BIND_HOST value is 127.0.0.1, but is only set if the BIND_PORT parameter is specified. Some examples:

Send output to default syslog port. Note that you might need to edit the /etc/rsyslog.conf file accordingly:

#### --serial udp,host=:514

Send output to remote host 192.168.10.20, port 4444. This output can be read on the remote host using nc -u -l 4444:

#### --serial udp,host=192.168.10.20:4444

#### --serial unix,path=UNIXPATH,mode=MODE

Specifies a UNIX socket. The MODE parameter has similar behavior and defaults as the tcp parameter.

#### --video=VIDEO

Specify what video device model will be attached to the guest. Valid values for the VIDEO parameter are hypervisor-specific.

### Other options

#### -h, --help

Show the help message and exit.

#### -d, --debug

Print debugging information to the terminal when running the installation process. The debugging information is also stored in $HOME/.virtinst/virt-install.log even if this parameter is omitted.

#### --autostart

Set the autostart flag for a domain. This parameter causes the domain to be started up on host boot.

#### --noreboot

Prevent the domain from automatically rebooting after the installation has completed.

#### --wait=WAIT

Amount of time to wait (in minutes) for a virtual machine to complete its install. Without this option, the virt-install tool waits for the console to close (not necessarily indicating the guest has shutdown), or in the case of the --noautoconsole, parameter, starts the installation and exits. Any negative value causes the virt-install tool to wait indefinitely, a value of 0 triggers the same results as --noautoconsole. If the time limit is exceeded, the virt-install tool exits, leaving the virtual machine in its current state.

#### --force

Prevent interactive prompts. If the intended prompt was a yes or no prompt, always say yes. For any other prompts, the application exits.

#### --prompt

Specifically enable prompting for required information. By default, prompting is off.

#### --check-cpu

Check that the number of virtual processors requested does not exceed physical processors and warn if they do.
