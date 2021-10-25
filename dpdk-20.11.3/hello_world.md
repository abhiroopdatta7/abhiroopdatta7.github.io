[< DPDK 20.11.3](README.md)

# Hello World

## Source Code

```c
#include <sys/types.h>
#include <sys/queue.h>

#include <rte_launch.h>
#include <rte_eal.h>
#include <rte_per_lcore.h>
#include <rte_lcore.h>
#include <rte_debug.h>
#include <rte_ethdev.h>

static const struct rte_eth_conf port_conf_default = {
    .rxmode = {
        .max_rx_pkt_len = RTE_ETHER_MAX_LEN,
    },
};

/* Dummy code to run on every lcore allocated. */
static int
lcore_hello(__attribute__((unused)) void *arg)
{
        unsigned lcore_id, socket_id;
        lcore_id = rte_lcore_id();
        socket_id = rte_socket_id();
        printf("hello world from core %u, socke %u\n", lcore_id, socket_id);
        rte_log(RTE_LOG_INFO, RTE_LOGTYPE_USER1, "hello from core %u\n", lcore_id);
        return 0;
}

int
main(int argc, char **argv)
{
    int ret;
    unsigned lcore_id;

    ret = rte_eal_init(argc, argv);
    if (ret < 0)
            rte_panic("Cannot init EAL\n");

    /* Print that number of nics. */
    uint16_t nb_ports;
    {
        nb_ports = rte_eth_dev_count_avail();
        rte_log(RTE_LOG_INFO, RTE_LOGTYPE_USER1, "Number of NICs: %u\n", nb_ports);
    }

    {
        /* Print number of cores. */
        /* -l 0-3 (on 4 cores, 0 to 3) */
        uint16_t lcores;
        lcores = rte_lcore_count();
        rte_log(RTE_LOG_INFO, RTE_LOGTYPE_USER1, "Number of COREs: %u\n", lcores);
    }

    {
        /* Print out the master core id */
        /* --master-lcore <core ID> */
        unsigned mcore_id;
        mcore_id = rte_lcore_id();
        rte_log(RTE_LOG_INFO, RTE_LOGTYPE_USER1, "\n== Master Core ID: %u ==\n", mcore_id);
    }
    
    /* call lcore_hello() on every slave lcore */
    RTE_LCORE_FOREACH(lcore_id) {
            rte_eal_remote_launch(lcore_hello, NULL, lcore_id);
    }

    /* call it on master lcore too */
    lcore_hello(NULL);

    rte_eal_mp_wait_lcore();
    return 0;
}
```



## Eexplanation

Here in this source code, we are doing `rte_eal_init()` to initialize dpdk, this accepts `argc` and `argv[]][]`

