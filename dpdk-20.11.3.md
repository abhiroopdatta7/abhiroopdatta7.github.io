[Home](https://raw.githubusercontent.com/abhiroopdatta7/abhiroopdatta7.github.io/main/README.md)

# DPDK 20.11.3

DPDK is the Data Plane Development Kit that consists of libraries to accelerate packet processing workloads running on a wide variety of CPU architectures.

DPDK was created in 2010 by Intel and made available under a permissive open source license.

## Important Links

- [Home](https://www.dpdk.org/)
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

## Source code

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

```bas
sudo ninja install -C ./build
```



