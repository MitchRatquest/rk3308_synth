echo "loading boot vars"
setenv load_addr "0x9000000"
load mmc ${devnum} ${load_addr} vars.txt
env import -t ${load_addr} ${filesize}

# lpj == loops per jiffy, it prints it out every boot
setenv bootargs "root=/dev/mmcblk1p2 earlyprintk console=ttyS0,1500000 rw rootwait lpj=24000"
fatload mmc ${devnum}:${distro_bootpart} ${fdt_addr_r} ${fdtfile}
fatload mmc ${devnum}:${distro_bootpart} ${kernel_addr_r} Image

# append overlays as required
setenv overlay_error "false"
fdt addr ${fdt_addr_r}
fdt resize 65536
for overlay_file in ${overlays}; do
  echo "loading overlay ${overlay_file}"
	if fatload mmc ${devnum}:${distro_bootpart} ${load_addr} rockchip/overlays/${overlay_file}.dtbo; then
		echo "Applying kernel provided DT overlay ${overlay_file}.dtbo"
		fdt apply ${load_addr} || setenv overlay_error "true"
	fi
done
if test "${overlay_error}" = "true"; then
	echo "Error applying DT overlays, restoring original DT"
  fatload mmc ${devnum}:${distro_bootpart} ${fdt_addr_r} ${fdtfile}
fi

booti ${kernel_addr_r} - ${fdt_addr_r}
