# autominecraftserver
## Scripts to automatically start and stop Minecraft Server

### Instructions for use:

`sudo adduser --system --group --home /opt/minecraft minecraft`

Download Minecraft Server to */opt/minecraft* and rename server JAR as *server.jar*

Set `server-port=25555` in server.properties

Copy **start.sh** and **stop.sh** to */opt/minecraft* and make them executable

`sudo -u minecraft /usr/bin/java -Xms1024M -Xmx1536M -jar server.jar nogui`

The Minecraft server should start and then stop saying the EULA needs to be accepted.

Set `eula=true` in */opt/minecraft/eula.txt*

`sudo apt install xinetd`

Copy **minecraft** to */etc/xinetd.d*

`sudo systemctl restart xinetd`

Add `*/5 * * * * /opt/minecraft/stop.sh` to crontab for user minecraft

### What does it do?

xinetd daemon is listening on the default Minecraft Server port (25565). When a client connects, xinetd runs */opt/minecraft/start.sh*, which, on the first connection, spawns the Minecraft Server (configured to listen on port 25555) using screen and then executes **netcat** to send/receive traffic from the client on port 25565 to the Minecraft Server on port 25555 via the loopback interface.

The **cron** job runs every five minutes, checks whether the Minecraft server is running and if so issues the `list` server command to check whether there are any active users. If not, then after waiting two minutes and checking again, the server is stopped. If there are active users, the script prints a random comedy message (this can be commented out if not needed).
