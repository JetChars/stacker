#!/bin/bash
# this script is for resize qcow2 image
# sudo apt-get install libguestfs-tools -y --force-yes 2>/dev/null || sudo yum install -y libguestfs-tools
qemu-img create -f qcow2 $2 $3
virt-resize -d --expand /dev/sda1 $1 $2
qemu-img info $2
