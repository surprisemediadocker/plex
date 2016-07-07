FROM surprisemediadocker/baseimage
MAINTAINER surprisemediadocker <surprisemediadocker@gmail.com>

RUN apt-get -q update && \
    apt-get -qy dist-upgrade && \
    apt-get install -qy curl dbus avahi-daemon \
    && \
    curl -L 'https://plex.tv/downloads/latest/1?channel=8&build=linux-ubuntu-x86_64&distro=ubuntu' -o /tmp/plexmediaserver.deb && \
    dpkg -i /tmp/plexmediaserver.deb && rm -f /tmp/plexmediaserver.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
	
COPY plexmediaserver /etc/default/plexmediaserver
RUN chown $NAME_USER:$NAME_USER /etc/default/plexmediaserver

COPY start.sh /start.sh
RUN chmod +x /start.sh
	
VOLUME ["/config"]

EXPOSE 32400

CMD ["/create_user.sh"]
ENTRYPOINT ["/start.sh"]
