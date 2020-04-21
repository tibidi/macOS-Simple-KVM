#!/bin/bash
export PATH=/ssd/qemu/qemu-4.2.0/bin:$PATH
#export PATH=/ssd/qemu/qemu-5.0.0/bin:$PATH
which qemu-system-x86_64

if [ $# -eq 0 ]
then
  echo "Syntaxe: $0 -i|--image=IMAGE -b|--big -v|--vnc"
  exit -1
fi
GRAPHIC="-display sdl,gl=on"
for i in "$@"
do
case $i in
    -i=*|--image=*)
    IMAGE="${i#*=}"
    shift # past argument=value
    ;;
    -b|--big)
    SIZE=BIG
    shift # past argument with no value
    ;;
    -v|--vnc)
    GRAPHIC="-nographic -vnc :1 -k fr"
    shift # past argument with no value
    ;;	
    -g|--gtk)
    GRAPHIC="-display gtk"
    shift # past argument with no value
    ;;	
    *)
          # unknown option
    ;;
esac
done
echo "IMAGE  = ${IMAGE}"
echo "SIZE   = ${SIZE}"
echo "GRAPHIC= ${GRAPHIC}"
echo "$@"


OSK="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
VMDIR=/ssd/apple/macOS-Simple-KVM
OVMF=$VMDIR/firmware
export QEMU_AUDIO_DRV=alsa
#QEMU_AUDIO_DRV=oss alsa sdl pa
#    -display gtk \
#    -vga qxl \
#    -display gtk,grab-on-hover=on,gl=on
#    -usb -device usb-kbd -device usb-mouse \
#    -spice port=5924,addr=127.0.0.1,disable-ticketing \

#    -smp 4,cores=4 \
#    -vga virtio \
#    -cpu Penryn,vendor=GenuineIntel,kvm=on,+sse3,+sse4.2,+aes,+xsave,+avx,+xsaveopt,+xsavec,+xgetbv1,+avx2,+bmi2,+smep,+bmi1,+fma,+movbe,+invtsc,vmx,rdtscp \
#   -vga virtio \

qemu-system-x86_64 \
    -m 6G \
    -machine q35,accel=hax \
    -cpu Penryn \
    -device isa-applesmc,osk="$OSK" \
    -smbios type=2 \
    -drive if=pflash,format=raw,readonly,file="$VMDIR/Catalina/OVMF_CODE.fd" \
    -drive if=pflash,format=raw,file="$VMDIR/Catalina/OVMF_VARS-1024x768.fd" \
    -device ich9-intel-hda -device hda-duplex \
    -usb -device usb-kbd -device usb-tablet \
    -netdev user,id=net0 \
    -device e1000-82545em,netdev=net0,id=net0,mac=52:54:00:c9:18:27 \
    -device ich9-ahci,id=sata \
    -drive id=ESP,if=none,format=qcow2,file=$VMDIR/Catalina/CloverNG.qcow2 \
    -device ide-hd,bus=sata.2,drive=ESP \
    -drive id=SystemDisk,if=none,file="$IMAGE" \
    -device ide-hd,bus=sata.4,drive=SystemDisk \
    -serial file:serial.out \
    $GRAPHIC
