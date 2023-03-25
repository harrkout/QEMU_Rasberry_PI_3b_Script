
# QEMU Raspberry Pi 3b virtualization

<br />


| Instructions |
--------------

<br />

---
 > Before you start download the *-arm64.img.xz image for the RPI3b from the raspiberry pi website
 ---


 - First, download the image Aarch64 imge from the Raspberry website, or any other desired architecture of any kind.
 
 <br/>

 - unzip the .img.xz file with :
     
     `unxz *.img.xz`

<br/>

- then, create a directory that is of offset equal to sectors*Device's Start offset

     run the following to get the information of sectors and start offset:
     
     `fdisk -l *.img `
     
     `mkdir <directory-name>`
     `sudo mount -v -o offset=$((sectors_No*Start_Offset)) *.img <directory-name>`

<br />

- After the image is mounter on the host machine, copy the desired .dtb along with the kernel*.mg file
  
  <br />
 - To enable ssh, inside the directory of the image/kernel run the command:
     
     `sudo touch ssh`
     `cd ..`
     `sudo umount <directory-name>`

<br />

 - Resize the image the raw image to the desired file-size

   `qemu-img resize -f raw *.img *G`
   > *G stands for desired image storage. Change * with desired number, e.g. 8G)

    <br />
   - Finally run the ./startpi.sh script to run the virtual machine.

    <br />
   - Check the flags bellow and modify the script.

    <br />

**Connect via ssh from host machine with command:**
 
`ssh -p 2022 user@localhost`

<br />

|  qemu flags: |
-----------------


 >- machine -> name of the machine
 >- cpu     -> name of architecture
 >- smp     -> symmetric multiprocessing, aka give number of CPU Cores
 >- m       -> RAM, default is 128MiB
 >- kernel  -> kernel directory (extracted from .img file). ARM-only prerequisite
 >- dtb     -> device-tree binary (ARM-only prerequisite)
 >- sd      -> SecureDigital card image (.img file)
 >- append   use cmdline as kernel command line

-----

```
qemu-system-aarch64 -machine raspi3b -cpu cortex-a53 -smp 4 -m 1G -kernel kernel8.img \
 -dtb bcm2710-rpi-3-b.dtb -sd 2023-02-21-raspios-bullseye-arm64-lite.img \
 -append "root=/dev/mmcblk0p2 rw rootwait rootfstype=ext4" \
 -usbdevice keyboard -usbdevice mouse -device usb-net,netdev=net0\
 -netdev user,id=net0,hostfwd=tcp::2022-:22
```

