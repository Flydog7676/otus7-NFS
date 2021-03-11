# OTUS ДЗ NFS,FUSE (Centos 7)
-----------------------------------------------------------------------
### Домашнее задание

Vagrant стенд для NFS
NFS:
vagrant up должен поднимать 2 виртуалки: сервер и клиент
на сервер должна быть расшарена директория
на клиента она должна автоматически монтироваться при старте (fstab или autofs)
в шаре должна быть папка upload с правами на запись
- требования для NFS: NFSv3 по UDP, включенный firewall

1. Настройка и конфигурирование сервера NFS  192.168.50.10   nfss
- Зайти на NFS сервер ```vagrant ssh nfss```
- установка необходимых пакетов ```sudo yum install -y nfs-utils nano firewalld```
- Создаем папки для экспорта и права на папку
```
sudo mkdir -p /mnt/shared /mnt/shared/upload
sudo chmod 0777 /mnt/shared
sudo chmod 0777 /mnt/shared/upload

```
- Редактируем файл экспорта ```tee -a /etc/exports <<< "/mnt/shared 192.168.50.0/24(rw,async)"```
- Применение обновлений экспортирования ```sudo exportfs -ra```
- Выкачиваем уже готовые наборы правил: ```firewall-cmd --get-services```
- Устанавливаем правила для работы необходимых демонов:
```
firewall-cmd --permanent --add-service=nfs3
firewall-cmd --permanent --add-service=mountd
firewall-cmd --permanent --add-service=rpc-bind
```
- установка и запуск фапуск фаервола:
```
systemctl enable firewalld
systemctl start firewalld
```
2. Настройка и конфигурирование клиента NFS  192.168.50.11   nfsс
- Зайти на NFS сервер ```vagrant ssh nfsс```
- установка необходимых пакетов ```sudo yum install -y nfs-utils nano```
- подключение NFS расшаренную папку c настройками NFSv3 по UDP :```sudo mount.nfs -vv 192.168.50.10:/mnt/shared /mnt -o nfsvers=3,proto=udp,soft```
- пробуем записать в примонтированную папку upload : ```dd if=/dev/zero of=/mnt/upload/test1G.zero bs=1M count=1024```









        








