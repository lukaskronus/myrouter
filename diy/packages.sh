#!/bin/sh

# Essential packages
git clone --depth=1 https://github.com/NagaseKouichi/luci-app-dnsproxy.git package/luci-app-dnsproxy
git clone --depth=1 -b luci2 https://github.com/lukaskronus/luci-proto-batman-adv.git package/luci-proto-batman-adv

# xray packages
git clone --depth=1 https://github.com/yichya/openwrt-xray.git package/openwrt-xray
git clone --depth=1 -b luci2 https://github.com/bi7prk/luci-app-xray.git package/luci-app-xray