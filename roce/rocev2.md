# RoCE

**RDMA** over Converged Ethernet (RoCE) is a network protocol which allows remote direct memory access (RDMA) over an Ethernet network. There are multiple RoCE versions. RoCE v1 is an Ethernet link layer protocol and hence allows communication between any two hosts in the same Ethernet broadcast domain. RoCE v2 is an internet layer protocol which means that RoCE v2 packets can be routed. Although the RoCE protocol benefits from the characteristics of a converged Ethernet network, the protocol can also be used on a traditional or non-converged Ethernet network.

## RoCE v2

The RoCE v2 protocol exists on top of either the **UDP/IPv4** or the **UDP/IPv6** protocol. The UDP destination port number **4791** has been reserved for RoCE v2. Since RoCEv2 packets are routable the RoCE v2 protocol is sometimes called Routable RoCE or RRoCE. Although in general the delivery order of UDP packets is not guaranteed, the RoCEv2 specification requires that packets with the same UDP source port and the same destination address must not be reordered. In addition, RoCEv2 defines a congestion control mechanism that uses the IP [ECN](#ip-explicit-congestion-notification) bits for marking and CNP frames for the acknowledgment notification. Software support for RoCE v2 is still emerging. Mellanox OFED 2.3 or later has RoCE v2 support and also Linux Kernel v4.5

![RoCEv2 Network Infrastructure](images/RoCEv2_Network_Infra.png)

## InfiniBand

InfiniBand (IB) is a computer networking communications standard used in high-performance computing that features very high throughput and very low latency. It is used for data interconnect both among and within computers. InfiniBand is also used as either a direct or switched interconnect between servers and storage systems, as well as an interconnect between storage systems. It is designed to be scalable and uses a switched fabric network topology. Between 2014 and June 2016, it was the most commonly used interconnect in the supercomputers.

## iWARP

iWARP is a computer networking protocol that implements remote direct memory access (RDMA) for efficient data transfer over TCP on Internet Protocol networks. iWARP is not an acronym.

## IP Explicit Congestion Notification

Explicit Congestion Notification (ECN) is an extension to the Internet Protocol and to the Transmission Control Protocol and is defined in RFC 3168 (2001). ECN allows end-to-end notification of network congestion without dropping packets. ECN is an optional feature that may be used between two ECN-enabled endpoints when the underlying network infrastructure also supports it.

Conventionally, TCP/IP networks signal congestion by dropping packets. When ECN is successfully negotiated, an ECN-aware router may set a mark in the IP header instead of dropping a packet in order to signal impending congestion. The receiver of the packet echoes the congestion indication to the sender, which reduces its transmission rate as if it detected a dropped packet.

ECN uses the two least significant (right-most) bits of the Traffic Class field in the IPv4 or IPv6 header to encode four different code points:

00 – Not ECN-Capable Transport, Not-ECT
01 – ECN Capable Transport(1), ECT(1)
10 – ECN Capable Transport(0), ECT(0)
11 – Congestion Experienced, CE.
