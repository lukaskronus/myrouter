#!/bin/bash

# Clone source code
latest_release="$(curl -s https://api.github.com/repos/openwrt/openwrt/tags | grep -Eo "v23.05.+[0-9\.]" | head -n 1)"
git clone --single-branch --filter=blob:none -b ${latest_release} https://github.com/openwrt/openwrt openwrt_release
git clone --single-branch --filter=blob:none -b openwrt-23.05 https://github.com/openwrt/openwrt openwrt

# Clone packages
git clone -b master --depth 1 --filter=blob:none https://github.com/immortalwrt/immortalwrt.git immortalwrt

# Move stable to snapshot
rm -f ./openwrt/include/version.mk
rm -f ./openwrt/include/kernel.mk
rm -f ./openwrt/include/kernel-5.15
rm -f ./openwrt/include/kernel-version.mk
rm -f ./openwrt/include/toolchain-build.mk
rm -f ./openwrt/include/kernel-defaults.mk
rm -f ./openwrt/package/base-files/image-config.in
rm -rf ./openwrt/target/linux/*
rm -rf ./openwrt/package/kernel/linux/*
cp -f ./openwrt_release/include/version.mk ./openwrt/include/version.mk
cp -f ./openwrt_release/include/kernel.mk ./openwrt/include/kernel.mk
cp -f ./openwrt_release/include/kernel-5.15 ./openwrt/include/kernel-5.15
cp -f ./openwrt_release/include/kernel-version.mk ./openwrt/include/kernel-version.mk
cp -f ./openwrt_release/include/toolchain-build.mk ./openwrt/include/toolchain-build.mk
cp -f ./openwrt_release/include/kernel-defaults.mk ./openwrt/include/kernel-defaults.mk
cp -f ./openwrt_release/package/base-files/image-config.in ./openwrt/package/base-files/image-config.in
cp -f ./openwrt_release/version ./openwrt/version
cp -f ./openwrt_release/version.date ./openwrt/version.date
cp -rf ./openwrt_release/target/linux/* ./openwrt/target/linux/
cp -rf ./openwrt_release/package/kernel/linux/* ./openwrt/package/kernel/linux/

# Clone patches
git clone -b master --depth 1 https://github.com/openwrt/packages.git openwrt_pkg_ma
git clone https://github.com/nicholas-opensource/OpenWrt-Autobuild
cp -r OpenWrt-Autobuild/PATCH/. ./PATCH

exit 0
