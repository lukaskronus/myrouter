#!/bin/bash

# Fix NAT Loopback
sed -i "/exit 0/i\echo 'net.bridge.bridge-nf-call-arptables=0' >> /etc/sysctl.conf\necho 'net.bridge.bridge-nf-call-ip6tables=0' >> /etc/sysctl.conf\necho 'net.bridge.bridge-nf-call-iptables=0' >> /etc/sysctl.conf" package/emortal/default-settings/files/99-default-settings