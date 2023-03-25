#!/bin/bash

# Modify Default IP
sed -i 's/192.168.1.1/192.168.41.1/g' package/base-files/files/bin/config_generate

# Modify default hostname
sed -i 's/ImmortalWrt/AkiKiiro/g' package/base-files/files/bin/config_generate

# Clean up dependencies for helloworld master
rm -rf feeds/packages/net/{chinadns-ng,dns2socks,dns2tcp,hysteria,ipt2socks,microsocks,naiveproxy,redsocks2,sagernet-core,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan,v2ray-core,v2ray-geodata,v2ray-plugin,v2raya,xray-core,xray-plugin}
rm -rf feeds/packages/lang/lua-neturl
rm -rf feeds/luci/applications/luci-app-ssr-plus

# Update Go to 1.20 for Xray-core build
rm -rf feeds/packages/lang/golang
svn co https://github.com/openwrt/packages/branches/openwrt-22.03/lang/golang feeds/packages/lang/golang