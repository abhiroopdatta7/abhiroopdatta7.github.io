## Build Requirements
To compile the userspace programs in the Open vSwitch distribution, you will need the following software:

-   GNU make
    
-   A C compiler, such as:
    
    -   GCC 4.6 or later.
    -   Clang 3.4 or later.
    -   MSVC 2013. Refer to [Open vSwitch on Windows](https://docs.openvswitch.org/en/latest/intro/install/windows/) for additional Windows build instructions.
    
    While OVS may be compatible with other compilers, optimal support for atomic operations may be missing, making OVS very slow (see `lib/ovs-atomic.h`).
    
-   libssl, from OpenSSL, is optional but recommended if you plan to connect the Open vSwitch to an OpenFlow controller. libssl is required to establish confidentiality and authenticity in the connections from an Open vSwitch to an OpenFlow controller. If libssl is installed, then Open vSwitch will automatically build with support for it.
    
-   libcap-ng, written by Steve Grubb, is optional but recommended. It is required to run OVS daemons as a non-root user with dropped root privileges. If libcap-ng is installed, then Open vSwitch will automatically build with support for it.
    
-   Python 3.4 or later.
    
-   Unbound library, from [http://www.unbound.net](http://www.unbound.net/), is optional but recommended if you want to enable ovs-vswitchd and other utilities to use DNS names when specifying OpenFlow and OVSDB remotes. If unbound library is already installed, then Open vSwitch will automatically build with support for it. The environment variable OVS_RESOLV_CONF can be used to specify DNS server configuration file (the default file on Linux is /etc/resolv.conf), and environment variable OVS_UNBOUND_CONF can be used to specify the configuration file for unbound.

To compile the kernel module on Linux, you must also install the following:

-   A supported Linux kernel version.
    
    For optional support of ingress policing, you must enable kernel configuration options `NET_CLS_BASIC`, `NET_SCH_INGRESS`, and `NET_ACT_POLICE`, either built-in or as modules. `NET_CLS_POLICE` is obsolete and not needed.)
    
    On kernels before 3.11, the `ip_gre` module, for GRE tunnels over IP (`NET_IPGRE`), must not be loaded or compiled in.
    
    To configure HTB or HFSC quality of service with Open vSwitch, you must enable the respective configuration options.
    
    To use Open vSwitch support for TAP devices, you must enable `CONFIG_TUN`.
    
-   To build a kernel module, you need the same version of GCC that was used to build that kernel.
    
-   A kernel build directory corresponding to the Linux kernel image the module is to run on. Under Debian and Ubuntu, for example, each linux-image package containing a kernel binary has a corresponding linux-headers package with the required build infrastructure.
    

If you are working from a Git tree or snapshot (instead of from a distribution tarball), or if you modify the Open vSwitch build system or the database schema, you will also need the following software:

-   `Autoconf` version 2.63 or later.
-   `Automake` version 1.10 or later.
-   `libtool` version 2.4 or later. (Older versions might work too.)

The datapath tests for userspace and Linux datapaths also rely upon:

-   pyftpdlib. Version 1.2.0 is known to work. Earlier versions should also work.
-   GNU wget. Version 1.16 is known to work. Earlier versions should also work.
-   netcat. Several common implementations are known to work.
-   curl. Version 7.47.0 is known to work. Earlier versions should also work.
-   tftpy. Version 0.6.2 is known to work. Earlier versions should also work.
-   netstat. Available from various distro specific packages

## Bootstrapping
This step is not needed if you have downloaded a released tarball. If you pulled the sources directly from an Open vSwitch Git tree or got a Git tree snapshot, then run boot.sh in the top source directory to build the “configure” script:

```bash
./boot.sh
```

## Configuring
OVS can be installed using different methods. For OVS to use DPDK, it has to be configured to build against the DPDK library (`--with-dpdk`).

Note

This section focuses on generic recipe that suits most cases. For distribution specific instructions, refer to one of the more relevant guides.

1.  Configure the package using the `--with-dpdk` flag:
    
    If OVS must consume DPDK static libraries (also equivalent to `--with-dpdk=yes` ):
    
```bash
./configure --with-dpdk=static
```
    
    If OVS must consume DPDK shared libraries:
    
```bash
./configure --with-dpdk=shared
```

## Building
1.  Run GNU make in the build directory, e.g.:

```bash
make
```

	or if GNU make is installed as “gmake”:
```bash
gmake
```

    If you used a separate build directory, run make or gmake from that directory, e.g.:
```bash
    $ make -C _gcc
    $ make -C _clang
``` 

	Note
    Some versions of Clang and ccache are not completely compatible. If you see unusual warnings when you use both together, consider disabling ccache.
    
2.  Run `make install` to install the executables and manpages into the running system, by default under `/usr/local`:

```bash
make install
```