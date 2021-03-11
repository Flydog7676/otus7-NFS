#!/bin/bash
yum install -y nfs-utils nano
mount.nfs -vv 192.168.50.10:/mnt/shared /mnt -o nfsvers=3,proto=udp,soft
echo FINISH
