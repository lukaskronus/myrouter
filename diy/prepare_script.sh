#!/bin/bash
clear

## Prepare
# GCC CFlags
sed -i 's/Os/O2/g' include/target.mk
# Add personal packages
git clone https://github.com/NagaseKouichi/luci-app-dnsproxy.git ./package/luci-app-dnsproxy
git clone -b luci2 https://github.com/lukaskronus/luci-proto-batman-adv.git ./package/luci-proto-batman-adv
git clone https://github.com/gSpotx2f/luci-app-cpu-status-mini.git ./package/luci-app-cpu-status-mini
# Update feeds
./scripts/feeds update -a && ./scripts/feeds install -a
# Irqbalance
sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config
# Victoria's secret
echo "net.netfilter.nf_conntrack_helper = 1" >>./package/kernel/linux/files/sysctl-nf-conntrack.conf
sed -i 's/default NODEJS_ICU_SMALL/default NODEJS_ICU_NONE/g' feeds/packages/lang/node/Makefile

## Important Patches
# Patches for SSL
rm -rf ./package/libs/mbedtls
cp -rf ../immortalwrt/package/libs/mbedtls ./package/libs/mbedtls
# Fix fstools
wget -qO - https://github.com/coolsnowwolf/lede/commit/8a4db76.patch | patch -p1
# BBRv3
cp -rf ../PATCH/BBRv3/kernel/* ./target/linux/generic/backport-5.15/

## Extra Packages
# Golang
rm -rf ./feeds/packages/lang/golang
cp -rf ../openwrt_pkg_ma/lang/golang ./feeds/packages/lang/golang
# Conntrack_Max
wget -qO - https://github.com/openwrt/openwrt/commit/bbf39d07.patch | patch -p1

## Ending
# My modificaions
sed -i 's/192.168.1.1/192.168.41.1/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/AkiKiiro/g' package/base-files/files/bin/config_generate