#!/bin/bash
shopt -s extglob

## Prepare
# Add personal packages
git clone https://github.com/gSpotx2f/luci-app-cpu-status.git ./package/luci-app-cpu-status
git clone https://github.com/gSpotx2f/luci-app-temp-status.git ./package/luci-app-temp-status
git clone https://github.com/gSpotx2f/luci-app-disks-info.git ./package/luci-app-disks-info

# Add turboacc packages
curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh

## Update feeds
# If the update is slow, use this command to swith from git.openwrt.org to github.com
# sed -i -E 's;git.openwrt.org/(feed|project);github.com/openwrt;' feeds.conf.default
./scripts/feeds update -a && ./scripts/feeds install -a

## Patching
# Irqbalance
sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config

## Ending
# My modificaions
sed -i 's/192.168.1.1/192.168.41.1/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/AkiKiiro/g' package/base-files/files/bin/config_generate

# Vermagic ImmortalWrt
latest_version="$(curl -s https://api.github.com/repos/immortalwrt/immortalwrt/tags | grep -Eo "v23.05.+[0-9\.]" | head -n 1 | sed 's/v//g')"
wget https://downloads.immortalwrt.org/releases/${latest_version}/targets/ramips/mt7621/packages/Packages.gz
zgrep -m 1 "Depends: kernel (=.*)$" Packages.gz | sed -e 's/.*-\(.*\))/\1/' >.vermagic
sed -i -e 's/^\(.\).*vermagic$/\1cp $(TOPDIR)\/.vermagic $(LINUX_DIR)\/.vermagic/' include/kernel-defaults.mk
