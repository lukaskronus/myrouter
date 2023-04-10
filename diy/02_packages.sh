#!/bin/bash

# Update feeds
./scripts/feeds update -a && ./scripts/feeds install -a
# Enable irqbalance
sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config
# Secret patches
sed -i '/unshift/d' scripts/download.pl
sed -i '/mirror02/d' scripts/download.pl
echo "net.netfilter.nf_conntrack_helper = 1" >> ./package/kernel/linux/files/sysctl-nf-conntrack.conf
sed -i 's/default NODEJS_ICU_SMALL/default NODEJS_ICU_NONE/g' feeds/packages/lang/node/Makefile
# My modifications
sed -i 's/192.168.1.1/192.168.41.1/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/AkiKiiro/g' package/base-files/files/bin/config_generate

# Packages
git clone https://github.com/NagaseKouichi/luci-app-dnsproxy ./feeds/luci/applications/luci-app-dnsproxy
git clone https://github.com/onemarcfifty/luci-proto-batman-adv ./feeds/luci/protocols/luci-proto-batman-adv