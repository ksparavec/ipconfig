#!/bin/bash
LOCKFILE="/sysroot/.network_configured"
[ -f $LOCKFILE ] && exit 0

for arg in `cat /proc/cmdline`;
do
  echo $arg | grep -q "^ip=" || continue
  config=`echo $arg | awk -F= '{print $2}'`
  ipaddr=`echo $config | awk -F: '{print $1}'`
  gateway=`echo $config | awk -F: '{print $3}'`
  prefix=`echo $config | awk -F: '{print $4}'`
  ifname=`echo $config | awk -F: '{print $6}'`
  break
done

cat >/sysroot/etc/sysconfig/network-scripts/ifcfg-${ifname} <<EOF
TYPE=Ethernet
BOOTPROTO=none
IPADDR=$ipaddr
PREFIX=$prefix
GATEWAY=$gateway
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=no
NAME=$ifname
DEVICE=$ifname
ONBOOT=yes
EOF

touch $LOCKFILE
exit 0
