#!/bin/bash

# Modify Default IP
sed -i 's/192.168.1.1/192.168.41.1/g' package/base-files/files/bin/config_generate

# Modify default hostname
sed -i 's/ImmortalWrt/AkiKiiro/g' package/base-files/files/bin/config_generate