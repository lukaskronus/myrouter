#!/bin/bash

# Clone source code
latest_release="$(curl -s https://api.github.com/repos/openwrt/openwrt/tags | grep -Eo "v23.05.+[0-9\.]" | head -n 1)"
git clone --single-branch --filter=blob:none -b ${latest_release} https://github.com/openwrt/openwrt openwrt
git clone --single-branch --filter=blob:none -b openwrt-23.05 https://github.com/openwrt/openwrt openwrt_snap

# Clone packages
git clone -b master --depth 1 --filter=blob:none https://github.com/immortalwrt/immortalwrt.git immortalwrt
git clone -b openwrt-23.05 --depth 1 --filter=blob:none https://github.com/immortalwrt/immortalwrt.git immortalwrt_23
git clone -b master --depth 1 --filter=blob:none https://github.com/immortalwrt/packages.git immortalwrt_pkg
git clone -b master --depth 1 --filter=blob:none https://github.com/immortalwrt/luci.git immortalwrt_luci
git clone -b openwrt-23.05 --depth 1 --filter=blob:none https://github.com/immortalwrt/luci.git immortalwrt_luci_23
git clone -b master --depth 1 --filter=blob:none https://github.com/coolsnowwolf/lede.git lede
git clone -b master --depth 1 --filter=blob:none https://github.com/coolsnowwolf/packages.git lede_pkg
git clone -b master --depth 1 --filter=blob:none https://github.com/coolsnowwolf/luci.git lede_luci
git clone -b main --depth 1 --filter=blob:none https://github.com/openwrt/openwrt.git openwrt_ma
git clone -b master --depth 1 --filter=blob:none https://github.com/openwrt/packages.git openwrt_pkg_ma
git clone -b master --depth 1 --filter=blob:none https://github.com/openwrt/luci.git openwrt_luci_ma

# Clone patches
git clone https://github.com/nicholas-opensource/OpenWrt-Autobuild
cp -r OpenWrt-Autobuild/PATCH/. ./PATCH

exit 0
