#!/bin/bash

# called by dracut
check() {
    [[ -d /etc/sysconfig/network-scripts ]] && return 0
    return 255
}

# called by dracut
depends() {
    echo "network"
    return 0
}

# called by dracut
install() {
    inst_binary df mount umount fdisk lsblk touch awk
    inst_hook pre-pivot 86 "$moddir/ipconfig.sh"
}

