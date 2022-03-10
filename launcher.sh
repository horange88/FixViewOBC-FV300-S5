#!/bin/bash

#echo $DISPLAY
#echo $GENICAM_ROOT_V3_0
#echo $TERM

## Configura la resolución
xrandr --output DP-1 --mode 1920x1080 --rate 60
xrandr --output HDMI-1 --mode 1920x1080 --rate 30

## Configura el driver de systec CAN
cd /home/fv300/Documentos/systec_can-master/
./install.sh

## Aplicación princiapl
cd /home/fv300/fix-fbuild/trunk/install/bin/
./fv300-s5

if [ $? -eq 0 ]
then 
  echo "[Launcher fv300] Aplicación finalizada correctamente"
  echo "[Launcher fv300] Apagando DVR"
  ssh -t jetson@192.168.10.12 "sudo shutdown -P now"
  echo "[Launcher fv300] Apagando OBC"
  sudo shutdown -P now
  exit 0
else
  echo "[Launcher] Reiniciando"
  exit 1
fi
