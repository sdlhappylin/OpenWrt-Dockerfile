FROM openwrtorg/rootfs

EXPOSE 80

RUN mkdir /var/lock && \
    opkg update && \
    opkg install luci openvpn-openssl openssl-util luci-app-openvpn luci-i18n-openvpn-zh-cn
    
USER root

VOLUME /etc/openvpn

# using exec format so that /sbin/init is proc 1 (see procd docs)
CMD ["/sbin/init"]
