FROM openwrtorg/rootfs

EXPOSE 80

RUN mkdir /var/lock && \
    opkg update && \
    opkg install luci kmod-tun uhttpd uhttpd-mod-lua openvpn-openssl openssl-util && \
    uci set uhttpd.main.interpreter='.lua=/usr/bin/lua' && \
    uci commit uhttpd && \
    opkg install luci-base luci-mod-admin-full luci-theme-bootstrap luci-i18n-base-en luci-i18n-firewall-en luci-i18n-base-fr luci-i18n-firewall-fr  && \
    opkg install luci-i18n-base-zh-cn  luci-proto-ipv6 luci-app-openvpn && \
    opkg install luci-app-uhttpd luci-app-upnp luci-app-ddns && \
    uci set network.lan.ifname=eth0 && \
    uci set network.lan.ipaddr=192.168.2.20 && \
    uci set network.vpn=interface && \
    uci set network.lan.gateway=192.168.2.1 && \
    uci set dhcp.lan.ignore=1 && \
    uci set network.vpn.proto='none' && \
    uci set network.vpn.ifname='tun' && \
    uci commit
	
USER root

# using exec format so that /sbin/init is proc 1 (see procd docs)
CMD ["/sbin/init"]
