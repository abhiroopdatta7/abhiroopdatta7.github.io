DPDK is the Data Plane Development Kit that consists of libraries to accelerate packet processing workloads running on a wide variety of CPU architectures.

DPDK was created in 2010 by Intel and made available under a permissive open source license.

## Important Links

- [DPDK Home](https://www.dpdk.org/)
- [LTS Version 20.11.3](http://fast.dpdk.org/rel/dpdk-20.11.3.tar.xz)
- [Linux Guide](http://doc.dpdk.org/guides-20.11/)
- [Release Note](http://doc.dpdk.org/guides/rel_notes/release_20_11.html)
- [Programmer’s Guide](http://doc.dpdk.org/guides-20.11/)
- [API Documentation](http://doc.dpdk.org/api-20.11/)



Install dependencies (for Ubuntu 20.04 LTS):

```bash
apt-get update -y

apt-get install -y linux-headers-$(uname -r) \
                   libpcap-dev    \
                   g++            \
                   ninja-build    \
                   python3-dev    \
                   python3-pip    \
                   pkg-config     \
                   openssl        \
                   libssl-dev     \
                   wget               

```

## Get Source Code

From download link:

```bash
wget http://fast.dpdk.org/rel/dpdk-20.11.3.tar.xz
```

Untar:

```bash
tar -xvf dpdk-20.11.3.tar.xz
```

## Build

```bash
meson -Dkernel_dir=/lib/modules/`uname -r` 
      -Denable_kmods=true 
      -Dexamples=all
      --buildtype=Release ./build

ninja -C ./build
```

## Install

```bash
sudo ninja install -C ./build
```

Download: [Installer Makefile](dpdk.make)



## Bind PMD Driver(vfio-pci)

```bash
/usr/local/bin/dpdk-devbind.py -s
```

The above command will show all the available devices supported by dpdk. The output may look like this:

```bash
Network devices using DPDK-compatible driver
============================================

Network devices using kernel driver
===================================
0000:1b:00.0 'Ethernet Controller X710 for 10GbE backplane 1581' if=ens9f0 drv=i40e unused=vfio-pci
0000:1b:00.1 'Ethernet Controller X710 for 10GbE backplane 1581' if=ens9f1 drv=i40e unused=vfio-pci
0000:1b:00.2 'Ethernet Controller X710 for 10GbE backplane 1581' if=ens9f2 drv=i40e unused=vfio-pci
0000:1b:00.3 'Ethernet Controller X710 for 10GbE backplane 1581' if=ens9f3 drv=i40e unused=vfio-pci

No 'Baseband' devices detected
==============================

No 'Crypto' devices detected
============================

No 'Eventdev' devices detected
==============================

No 'Mempool' devices detected
=============================

No 'Compress' devices detected
==============================

Misc (rawdev) devices using kernel driver
=========================================

```

From here we can see that there are four available nics (0000:1b:00.0 - 0000:1b:00.3) which currently using i40e driver.

Now if want to bind `vfio-pci` to the first Nic, i.e. 0000:1b:00.0 :

```bash
/usr/local/bin/dpdk-devbind.py -b vfio-pci 0000:1b:00.0
```

Let's check whats changes:

```bash
/usr/local/bin/dpdk-devbind.py -s
```

```bash
Network devices using DPDK-compatible driver
============================================
0000:1b:00.0 'Ethernet Controller X710 for 10GbE backplane 1581' drv=vfio-pci unused=i40e

Network devices using kernel driver
===================================
0000:1b:00.1 'Ethernet Controller X710 for 10GbE backplane 1581' if=ens9f1 drv=i40e unused=vfio-pci
0000:1b:00.2 'Ethernet Controller X710 for 10GbE backplane 1581' if=ens9f2 drv=i40e unused=vfio-pci
0000:1b:00.3 'Ethernet Controller X710 for 10GbE backplane 1581' if=ens9f3 drv=i40e unused=vfio-pci
```







## Example

1. [Hello world](DPDK-20.11.3-hello-world.md)

