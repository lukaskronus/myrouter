#!/bin/bash
shopt -s extglob

## Add package repo
echo 'src-git fichenx https://github.com/fichenx/openwrt-package' >>feeds.conf.default

## Update feeds
./scripts/feeds update -a && ./scripts/feeds install -a

################## Theme Modification ##########################
sed -i 's|set luci.main.mediaurlbase|#set luci.main.mediaurlbase|g' feeds/luci/themes/luci-theme-argon/root/etc/uci-defaults/30_luci-theme-argon
sed -i 's|set luci.main.mediaurlbase|#set luci.main.mediaurlbase|g' feeds/luci/themes/luci-theme-argon-mod/root/etc/uci-defaults/90_luci-theme-argon
sed -i 's|set luci.main.mediaurlbase|#set luci.main.mediaurlbase|g' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's|set luci.main.mediaurlbase|#set luci.main.mediaurlbase|g' feeds/luci/themes/luci-theme-material/root/etc/uci-defaults/30_luci-theme-material
sed -i 's|set luci.main.mediaurlbase|#set luci.main.mediaurlbase|g' feeds/luci/themes/luci-theme-netgear/root/etc/uci-defaults/30_luci-theme-netgear
sed -i 's/luci-theme-bootstrap/luci-theme-design/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-design/g' feeds/luci/collections/luci-light/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-design/g' feeds/luci/collections/luci-nginx/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-design/g' feeds/luci/collections/luci-ssl-nginx/Makefile

sed -i 's/luci-theme-argon/luci-theme-design/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-argon/luci-theme-design/g' feeds/luci/collections/luci-light/Makefile
sed -i 's/luci-theme-argon/luci-theme-design/g' feeds/luci/collections/luci-nginx/Makefile
sed -i 's/luci-theme-argon/luci-theme-design/g' feeds/luci/collections/luci-ssl-nginx/Makefile


################## Fix Error Compilation ##########################

#Fix elfutils error
git_svn master https://github.com/coolsnowwolf/lede package/libs/elfutils

#Fix openssh error
rm -rf feeds/packages/net/openssh
git_sparse_clone master https://github.com/coolsnowwolf/packages net/openssh && mv -n openssh feeds/packages/net/openssh

#Fix autocore error
sed -i 's/DEPENDS:=@(.*/DEPENDS:=@(arm||aarch64) \\/g' package/lean/autocore/Makefile

#Fix zlib error
git_sparse_clone main https://github.com/openwrt/openwrt package/libs/zlib && mv -n zlib package/libs/zlib
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.3.1/g' tools/zlib/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=9a93b2b7dfdac77ceba5a558a580e74667dd6fede4585b91eefb60f03b72df23/g' tools/zlib/Makefile

## Ending
# My modificaions
sed -i 's/192.168.1.1/192.168.41.1/g' package/base-files/files/bin/config_generate
sed -i 's/LEDE/NewifiD2/g' package/base-files/files/bin/config_generate