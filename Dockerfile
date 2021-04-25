FROM sulinggg/openwrt:x86_64

EXPOSE 80

RUN mkdir /var/lock && \
    opkg update && \
    opkg install luci kmod-tun uhttpd uhttpd-mod-lua openvpn-openssl openssl-util && \
    opkg install luci-base luci-mod-admin-full luci-theme-bootstrap luci-i18n-base-en luci-i18n-firewall-en luci-i18n-base-fr luci-i18n-firewall-fr  && \
    opkg install luci-i18n-base-zh-cn  luci-proto-ipv6 luci-app-openvpn && \
    opkg install luci-app-uhttpd luci-app-upnp luci-app-ddns
USER root

# using exec format so that /sbin/init is proc 1 (see procd docs)
CMD ["/sbin/init"]
