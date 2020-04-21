cd ..
/ssd/qemu/qemu-4.2.0/bin/qemu-system-x86_64 -monitor stdio -no-reboot \
 -machine q35 -m 8G -usb -device usb-kbd -device usb-tablet \
 -device isa-applesmc,osk="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc" \
 -drive if=pflash,format=raw,readonly,file=Catalina/OVMF_CODE.fd \
 -drive if=pflash,format=raw,file=Catalina/OVMF_VARS-1024x768.fd \
 -smbios type=2 -device ich9-intel-hda -device hda-duplex \
 -accel hax \
 -cpu Penryn,vendor=GenuineIntel,kvm=on,+sse3,+sse4.2,+aes,+xsave,+avx,+xsaveopt,+xsavec,+xgetbv1,+avx2,+bmi2,+smep,+bmi1,+fma,+movbe,+invtsc,rdtscp \
 -device ide-drive,bus=ide.1,drive=Clover -drive id=Clover,if=none,snapshot=on,format=qcow2,file=Catalina/CloverNG.qcow2 \
 -device ide-drive,bus=ide.2,drive=LinuxHDD -drive id=LinuxHDD,if=none,file=/ssd/utmp/MyDisk.qcow2,format=qcow2 \
 -display gtk -k fr
cd -

