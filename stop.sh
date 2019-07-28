#!/bin/bash
messages=("say Oh, you are still playing - just checking!" "say Still there I see...OK, no worries!"
          "say Not bored yet? Fair enough!" "say Are you having fun still?"
          "say Minecraft is addictive!!" "say You are using a lot of electricity you know!"
          "say My circuits are overheating! Is it time to have a break?")

if pgrep -U minecraft -f server.jar > /dev/null ; then
  /usr/bin/screen -p 0 -S mc -X clear
  /usr/bin/screen -p 0 -S mc -X eval 'stuff "list"\015'
  /bin/sleep 0.5
  /usr/bin/screen -p 0 -S mc -X hardcopy /tmp/usercheck
  if grep "There are 0 " /tmp/usercheck > /dev/null ; then
    /bin/sleep 60
    /usr/bin/screen -p 0 -S mc -X clear
    /usr/bin/screen -p 0 -S mc -X eval 'stuff "list"\015'
    /bin/sleep 0.5
    /usr/bin/screen -p 0 -S mc -X hardcopy /tmp/usercheck
    if grep "There are 0 " /tmp/usercheck > /dev/null ; then
      echo Stopped server at `date` > /opt/minecraft/laststop
      /usr/bin/screen -p 0 -S mc -X eval 'stuff "save-all"\015'
      /usr/bin/screen -p 0 -S mc -X eval 'stuff "stop"\015'
    fi
  else
    RANDOM=$$
    message=${messages[$(($RANDOM % ${#messages[@]}))]}
    /usr/bin/screen -p 0 -S mc -X eval 'stuff "'"$message"'"\015'
  fi
fi
