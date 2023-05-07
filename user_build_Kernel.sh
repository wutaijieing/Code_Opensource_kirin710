#!/bin/bash
#设置环境

# Special Clean For Huawei Kernel.
if [ -d include/config ];
then
    echo "Find config,will remove it"
	rm -rf include/config
else
	echo "No Config,good."
fi


echo " "
echo "***Setting environment...***"
# 交叉编译器路径
export PATH=$PATH:
export CROSS_COMPILE=

export GCC_COLORS=auto
export ARCH=arm64
if [ ! -d "out" ];
then
	mkdir out
fi

#输入Kirin710内核版本号
printf "Please enter Kirin710 Kernel version number: "
read v
echo " "
echo "Setting EXTRAVERSION"
export EV=EXTRAVERSION=_Kirin710_KSU_V$v

#构建Kirin710内核部分
echo "***Building for Kirin710 version...***"
make ARCH=arm64 O=out $EV Kirin710_KSU_defconfig
# 定义编译线程数
make ARCH=arm64 O=out $EV -j256

#打包Kirin710版内核

if [ -f out/arch/arm64/boot/Image.gz ];
then
	echo "***Packing Kirin710 version kernel...***"

	tools/mkbootimg --kernel out/arch/arm64/boot/Image.gz --base 0x0 --cmdline "loglevel=4 initcall_debug=n page_tracker=on unmovable_isolate1=2:192M,3:224M,4:256M printktimer=0xfff0a000,0x534,0x538 androidboot.selinux=enforcing buildvariant=user" --tags_offset 0x07A00000 --kernel_offset 0x00080000 --ramdisk_offset 0x07c00000 --header_version 1 --os_version 9 --os_patch_level 2019-03-01 --output Kirin710_V"$v"_9.0.img

	tools/mkbootimg --kernel out/arch/arm64/boot/Image.gz --base 0x0 --cmdline "loglevel=4 initcall_debug=n page_tracker=on unmovable_isolate1=2:192M,3:224M,4:256M printktimer=0xfff0a000,0x534,0x538 androidboot.selinux=permissive buildvariant=user" --tags_offset 0x07A00000 --kernel_offset 0x00080000 --ramdisk_offset 0x07c00000 --header_version 1 --os_version 9 --os_patch_level 2019-03-01 --output Kirin710_V"$v"_9.0_PM.img
	
	cp out/arch/arm64/boot/Image.gz Image.gz 

	echo " "
	echo "***Sucessfully built Kirin710 version kernel...***"
	echo " "
	exit 0
else
	echo " "
	echo "***Failed!***"
	exit 0
fi