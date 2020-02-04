Install libguestfs-tools using your package manager
Mount the first partition in the ESP image using sudo guestmount -a ESP.qcow2 -m /dev/sda1 /mnt
Open the directory (you'll probably need to use your root user for this). cd /mnt
Navigate into the Clover directory (like above) and edit config.plist
Unmount the image using sudo guestunmount /mnt
1440x900

