#!/bin/bash
set -x

name=template
ip=192.168.2.43
hostname="${name}.internal"

cp fed-minimal.ks.template fed-minimal.ks
sed -i 's/__IP__/'${ip}'/g' fed-minimal.ks
sed -i 's/__HOSTNAME__/'${hostname}'/g' fed-minimal.ks

virt-install --connect qemu:///system\
	--network bridge:br0 \
  --initrd-inject fed-minimal.ks \
  --console pty,target_type=serial \
	--name ${name} \
	--disk /local1/vm/${name}/disk,size=16 \
	--ram 4096 \
	--vcpus 2 \
	--location /local1/iso/Fedora-Server-dvd-x86_64-33-1.2.iso \
  --graphics none \
  --os-type linux \
  --extra-args "ks=file:/fed-minimal.ks console=tty0 console=ttyS0,115200n8 serial"
