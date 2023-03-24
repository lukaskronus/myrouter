#!/bin/bash

# Helloworld packages collection
git clone --depth=1 https://github.com/fw876/helloworld package/helloworld
# LuCi for dnsproxy
git clone --depth=1 https://github.com/NagaseKouichi/luci-app-dnsproxy.git package/luci-app-dnsproxy
# LuCi for xray-core
git clone --depth=1 -b luci2 https://github.com/bi7prk/luci-app-xray.git package/luci-app-xray