FROM sulinggg/openwrt:x86_64

EXPOSE 80

RUN mkdir /var/lock && \
    opkg update && \
    opkg install openvpn-openssl  luci-app-openvpn
    
VOLUME /etc/openvpn

USER root

# using exec format so that /sbin/init is proc 1 (see procd docs)
CMD ["/sbin/init"]
