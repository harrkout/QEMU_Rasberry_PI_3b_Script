#!/bin/bash

qemu-system-aarch64 -machine raspi3b -cpu cortex-a53 -smp 4 -m 1G -kernel kernel8.img \
 -dtb bcm2710-rpi-3-b.dtb -sd 2023-02-21-raspios-bullseye-arm64-lite.img \
 -append "root=/dev/mmcblk0p2 rw rootwait rootfstype=ext4" \
 -usbdevice keyboard -usbdevice mouse -device usb-net,netdev=net0\
 -netdev user,id=net0,hostfwd=tcp::2022-:22
