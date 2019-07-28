#!/bin/bash
if ! pgrep -U minecraft -f server.jar > /dev/null ; then
  cd /opt/minecraft
  echo Started server at `date` > /opt/minecraft/laststart
  /usr/bin/screen -DmS mc /usr/bin/java -Xms1024M -Xmx1536M -jar server.jar nogui
fi
exec /bin/nc 127.0.0.1 25555
