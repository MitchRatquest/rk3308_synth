#!/bin/sh

RKBIN=$BINARIES_DIR/rkbin
RKTOOLS=$RKBIN/tools
RKCHIP_LOADER=$2
RKCHIP=$2

if [ $RKCHIP = "RK3308" ]; then
  if grep -q '^CONFIG_ARM64_BOOT_AARCH32=y' ${BASE_DIR}/.config ; then
    PLATFORM_UBOOT_IMG_SIZE="--size 512 2"
    PLATFORM_AARCH32="AARCH32"
  else
    PLATFORM_UBOOT_IMG_SIZE="--size 1024 2"
  fi
fi

# copy uboot variable file over
SCRIPT_DIR="$(dirname $0)"
#SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
#echo "HERE I AM: $SCRIPT_DIR"
cp -a $SCRIPT_DIR/vars.txt $BINARIES_DIR/

# copy overlays over
linuxDir=`find $BASE_DIR/build -name 'vmlinux' -type f | xargs dirname`
mkdir -p $BINARIES_DIR/rockchip/overlays
cp -a ${linuxDir}/arch/arm64/boot/dts/rockchip/overlay/*.dtbo $BINARIES_DIR/rockchip/overlays

ubootName=`find $BASE_DIR/build -name 'uboot-[0-9]*' -type d`

# uboot creation
$RKTOOLS/loaderimage --pack --uboot $ubootName/u-boot-dtb.bin $BINARIES_DIR/uboot.img 0x600000 --size 1024 1

# trust img creation
cat >$ubootName/trust.ini <<EOF
[VERSION]
MAJOR=1
MINOR=0
[BL30_OPTION]
SEC=0
[BL31_OPTION]
SEC=1
PATH=$SCRIPT_DIR/rk3308_bl31_v2.10.elf
ADDR=0x00010000
[BL32_OPTION]
SEC=0
[BL33_OPTION]
SEC=0
[OUTPUT]
PATH=$BINARIES_DIR/trust.img
EOF
$RKBIN/tools/trust_merger --size 1024 1 ${ubootName}/trust.ini

# first stage boot loader creation
$ubootName/tools/mkimage -n rk3308 -T rksd -d $SCRIPT_DIR/rk3308_ddr_589MHz_uart0_m0_v1.26.bin $BINARIES_DIR/idbloader.img
cat $SCRIPT_DIR/rk3308_miniloader_emmc_port_support_sd_20190717.bin >> $BINARIES_DIR/idbloader.img

# Generate the uboot script
$ubootName/tools/mkimage -C none -A arm -T script -d $SCRIPT_DIR/boot.cmd $BINARIES_DIR/boot.scr

# Put the device trees into the correct location
mkdir -p $BINARIES_DIR/rockchip; cp -a $BINARIES_DIR/*.dtb $BINARIES_DIR/rockchip
$BASE_DIR/buildroot/support/scripts/genimage.sh -c $SCRIPT_DIR/genimage.cfg

echo
echo
echo compilation done
echo
echo
echo
echo write your image to the sdcard, don\'t forget to change OF=/dev/sdb to your sdcard drive ...
echo use the following command ...
echo
echo 'OF=/dev/sdb; rootDrive=`mount | grep " / " | grep $OF`; if [ -z $rootDrive ]; then sudo umount $OF[123456789]; sudo dd if=output/images/sdcard.img of=$OF; else echo you are trying to overwrite your root drive; fi'
echo
