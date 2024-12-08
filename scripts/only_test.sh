#!/bin/bash
shopt -s extglob

## Prepare
# Add personal packages
git clone https://github.com/gSpotx2f/luci-app-cpu-status-mini.git ./package/luci-app-cpu-status-mini

## Update feeds
./scripts/feeds update -a && ./scripts/feeds install -a

## Patching
# Irqbalance
sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config

## Ending
# My modificaions
sed -i 's/192.168.1.1/192.168.41.1/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/AkiKiiro/g' package/base-files/files/bin/config_generate