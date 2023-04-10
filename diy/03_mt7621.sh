#!/bin/bash

# Match Vermagic
latest_release="$(curl -s https://api.github.com/repos/immortalwrt/immortalwrt/tags | grep -Eo "v21.02.+[0-9\.]" | head -n 1)"
wget https://downloads.immortalwrt.org/releases/${latest_release}/targets/ramips/mt7621/packages/Packages.gz
zgrep -m 1 "Depends: kernel (=.*)$" Packages.gz | sed -e 's/.*-\(.*\))/\1/' > .vermagic
sed -i -e 's/^\(.\).*vermagic$/\1cp $(TOPDIR)\/.vermagic $(LINUX_DIR)\/.vermagic/' include/kernel-defaults.mk