#!/bin/bash

if [ ! -d "/config/Library" ]; then
  mkdir /config/Library
  chown $NAME_USER:$NAME_USER /config/Library
fi


if [ ! -f "/config/Library/chown.lock" ]; then
  echo "Chown in progress ..."
  find /config/Library ! \( -user $NAME_USER -a -group $NAME_USER \) -print0 | xargs -0 chown $NAME_USER:$NAME_USER
  touch /config/Library/chown.lock
fi

sed -i "s/PLEX_MEDIA_SERVER_USER=smd/PLEX_MEDIA_SERVER_USER=$NAME_USER/g" /etc/default/plexmediaserver

echo "Starting Plex Media Server."
exec /usr/sbin/start_pms

