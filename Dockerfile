FROM openwrtorg/rootfs:x86-64

EXPOSE 80

RUN mkdir /var/lock && \
    opkg update && \
    opkg install uhttpd uhttpd-mod-lua luci-base luci-mod-admin-full luci-theme-bootstrap luci-i18n-base-en luci-i18n-firewall-en luci-i18n-base-fr luci-i18n-firewall-fr opkg install luci-i18n-base-zh-cn && \
    uci set luci.ccache.enable=0 && \
    uci commit luci && \
    uci set uhttpd.main.interpreter='.lua=/usr/bin/lua' && \
    uci commit uhttpd

USER root

# using exec format so that /sbin/init is proc 1 (see procd docs)
CMD ["/sbin/init"]
