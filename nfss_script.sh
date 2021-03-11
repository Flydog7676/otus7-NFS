#!/bin/bash
yum install -y nfs-utils nano firewalld
systemctl enable nfs-server
systemctl start nfs-server
systemctl enable rpc-statd
systemctl start rpc-statd
systemctl enable nfs-idmapd
systemctl start nfs-idmapd
systemctl enable firewalld
systemctl start firewalld
sudo mkdir -p /mnt/shared /mnt/shared/upload
chmod 0777 /mnt/shared
chmod 0777 /mnt/shared/upload
tee -a /etc/exports <<< "/mnt/shared 192.168.50.0/24(rw,async)"
exportfs -ra
firewall-cmd --get-services
firewall-cmd --permanent --add-service=nfs3
firewall-cmd --permanent --add-service=mountd
firewall-cmd --permanent --add-service=rpc-bind
firewall-cmd --reload
systemctl start firewalld
echo FINISH
