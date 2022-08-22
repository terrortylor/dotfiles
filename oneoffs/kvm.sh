#! /bin/bash

set -e

sudo apt -y install cpu-checker qemu qemu-kvm virt-manager libvirt-daemon-system virtinst libvirt-clients bridge-utils
sudo apt -y install virt-manager

sudo usermod -aG kvm "$USER"
sudo usermod -aG libvirt "$USER"

sudo mkdir -p /var/lib/libvirt/shared

if ! sudo virsh pool-uuid vm-images; then
sudo virsh pool-define-as vm-images dir --target /var/lib/libvirt/shared/vm-images
fi
if ! sudo virsh pool-uuid vm-isos; then
sudo virsh pool-define-as vm-isos dir --target /var/lib/libvirt/shared/vm-isos
fi
if ! sudo virsh pool-uuid vm-templates; then
sudo virsh pool-define-as vm-templates dir --target /var/lib/libvirt/shared/vm-templates
fi

if ! sudo virsh pool-info vm-images| grep running ; then
sudo virsh pool-start vm-images
fi

if ! sudo virsh pool-info vm-isos| grep running ; then
sudo virsh pool-start vm-isos
fi

if ! sudo virsh pool-info vm-templates| grep running ; then
sudo virsh pool-start vm-templates
fi
