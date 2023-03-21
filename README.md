\#

\#  \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*

\# =======================================================================================

\# || Author  :Harry Koutsourelakis                                                     ||

\# || Email   :harrkout@gmail.com                                                       ||

\# =======================================================================================

\#

\#                           ---------------

\#                          | Instructions |

\#                          ---------------

\#

\# Before you start download the \*-arm64.img.xz image for the RPI3b from the raspiberry pi website

\# ===============================================================================================

\#

\#

\# First, download the image aarch64 imge from the Raspberry website,

\# or any other desired architecture of any kind.

\#

\# unzip the .img.xz file with :

\#

\#     unxz \*.img.xz

\#

\# then, create a directory that is of offset equal to sectors\*Device's Start offset

\#

\#     run: fdisk -l \*.img

\#     to get the information of sectors and start offset

\#

\#     mkdir <directory-name>

\#     sudo mount -v -o offset=$((sectors\_No\*Start\_Offset)) \*.img <directory-name>

\#

\#  After the image is mounter on the host machine, copy the desired .dtb along with the kernel\*.img file

\#

\# To enable ssh, inside the directory of the image/kernel run the command:

\#

\#     sudo touch ssh

\#     cd ..

\#     sudo umount <directory-name>

\#

\# Resize the image the raw image to the desired file-size

\#

\#   qemu-img resize -f raw \*.img \*G

\#   //\* for number, G for gigabytes

\#

\#   finally run the ./startpi.sh script to run the virtual machine.

\#   Check the flags bellow and modify the script.

\#

\#

#===================================================================================

\#

\#                                 ------------------

\#                                 ||  qemu flags: ||

\#                                 -----------------

\#

\#

\# -machine -> name of the machine

\# -cpu     -> name of architecture

\# -smp     -> symmetric multiprocessing, aka give number of CPU Cores

\# -m       -> RAM, default is 128MiB

\# -kernel  -> kernel directory (extracted from .img file). ARM-only prerequisite

\# -dtb     -> device-tree binary (ARM-only prerequisite)

\# -sd      -> SecureDigital card image (.img file)

\# -append  -> use cmdline as kernel command line

\#

#===================================================================================

\#

\# \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*

\#

qemu-system-aarch64 -machine raspi3b -cpu cortex-a53 -smp 4 -m 1G -kernel kernel8.img \

- dtb bcm2710-rpi-3-b.dtb -sd 2023-02-21-raspios-bullseye-arm64-lite.img \
- append "root=/dev/mmcblk0p2 rw rootwait rootfstype=ext4" \
- usbdevice keyboard -usbdevice mouse -device usb-net,netdev=net0\
- netdev user,id=net0,hostfwd=tcp::2022-:22

#connect via ssh from host machine with command:

#ssh -p 2022 user@localhost

\#

#username: harrkout

#pwd:      rth
