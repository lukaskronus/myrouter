#!/bin/bash
shopt -s extglob

## Prepare
# Add personal packages
#git clone https://github.com/NagaseKouichi/luci-app-dnsproxy.git ./package/luci-app-dnsproxy
#git clone -b luci2 https://github.com/lukaskronus/luci-proto-batman-adv.git ./package/luci-proto-batman-adv
git clone https://github.com/gSpotx2f/luci-app-cpu-status.git ./package/luci-app-cpu-status
git clone https://github.com/gSpotx2f/luci-app-temp-status.git ./package/luci-app-temp-status
git clone https://github.com/animegasan/luci-app-wolplus.git package/luci-app-wolplus

# Add Mediatek driver
# git clone https://github.com/ALSe61/openwrt-r3p-mtk.git
# rsync -av openwrt-r3p-mtk/target/ ./target && rsync -av --delete openwrt-r3p-mtk/package/mt/ ./package/mt

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