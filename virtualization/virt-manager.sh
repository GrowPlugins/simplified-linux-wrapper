#!/bin/sh

sudo apt install cpu-checker -y
kvmOk=$(sudo kvm-ok | grep 'can be used');

if [ "$kvmOk" != '' ]
then

    sudo apt install qemu-kvm qemu-utils virt-manager #dnsmasq;

    #systemctl stop dnsmasq && systemctl deactivate dnsmasq;

    sudo usermod -a -G libvirt $USER

    # Autostart KVM Network
    sudo virsh net-start default;
    sudo virsh net-autostart default;
else

    echo 'There might be a problem with installation of KVM.';
    echo 'kvm-ok reports:';
    echo;

    sudo kvm-ok;
fi
