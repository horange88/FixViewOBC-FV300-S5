#!/bin/bash

echo "Clean"
make clean
echo "Make Driver"
make  
echo "Load CAN Module"
sudo modprobe can_raw
sudo modprobe can_dev
echo "Install Driver"
sudo insmod systec_can.ko


sudo ip link set can0 type can bitrate 250000
sudo ip link set can0 up
