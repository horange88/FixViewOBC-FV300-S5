#!/bin/bash

if [ "$1" == "" ]
then
  echo "Usage: canConfig [DEV] [BITRATE] "
  
else
  DEV="$1"
  BITRATE="$2"

  #echo "ifconfig $DEV down"
  #echo "ip link set $DEV type can bitrate $BITRATE "
  #echo "ifconfig $DEV up"

  ifconfig $DEV down
  ip link set $DEV type can bitrate $BITRATE
  ifconfig $DEV up
fi



