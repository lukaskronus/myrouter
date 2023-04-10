#!/bin/bash

# Clone source code
latest_release="$(curl -s https://api.github.com/repos/immortalwrt/immortalwrt/tags | grep -Eo "v21.02.+[0-9\.]" | head -n 1)"
git clone --single-branch -b $(latest_release) https://github.com/immortalwrt/immortalwrt.git immortalwrt_release
git clone --single-branch -b immortalwrt-21.02 https://github.com/immortalwrt/immortalwrt.git immortalwrt
rm -f ./immortalwrt/include/version.mk
rm -f ./immortalwrt/include/kernel.mk
rm -f ./immortalwrt/include/kernel-5.10
rm -f ./immortalwrt/include/kernel-version.mk
rm -f ./immortalwrt/include/toolchain-build.mk
rm -f ./immortalwrt/include/kernel-defaults.mk
rm -f ./immortalwrt/package/base-files/image-config.in
rm -rf ./immortalwrt/target/linux/*
rm -rf ./immortalwrt/package/kernel/linux/*
cp -f ./immortalwrt_release/include/version.mk ./immortalwrt/include/version.mk
cp -f ./immortalwrt_release/include/kernel.mk ./immortalwrt/include/kernel.mk
cp -f ./immortalwrt_release/include/kernel-5.10 ./immortalwrt/include/kernel-5.10
cp -f ./immortalwrt_release/include/kernel-version.mk ./immortalwrt/include/kernel-version.mk
cp -f ./immortalwrt_release/include/toolchain-build.mk ./immortalwrt/include/toolchain-build.mk
cp -f ./immortalwrt_release/include/kernel-defaults.mk ./immortalwrt/include/kernel-defaults.mk
cp -f ./immortalwrt_release/package/base-files/image-config.in ./immortalwrt/package/base-files/image-config.in
cp -f ./immortalwrt_release/version ./immortalwrt/version
cp -f ./immortalwrt_release/version.date ./immortalwrt/version.date
cp -rf ./immortalwrt_release/target/linux/* ./immortalwrt/target/linux/
cp -rf ./immortalwrt_release/package/kernel/linux/* ./immortalwrt/package/kernel/linux/

# Clone package repos
git clone -b master --depth 1 https://github.com/QiuSimons/OpenWrt-Add.git OpenWrt-Add

exit 0