#!/bin/bash
# Timelapse Controller for USB Webcam
# Takes and saves 1440 photos from webcam (while x <= 1440) (saves 1 photo every 5 seconds) 
# Created by: Jackie Staiger (Feb 2020)
# In order to run this script immediately when the pi boots up, 

DIR=/home/pi/pool_pics

x=1
while [ $x -le 1440 ]; do 

filename=$(date -u +"%d%mY_%H%M-%S").jpg

fswebcam -d /dev/video0 -r 1280x720 $DIR/$filename

x=$(( $x + 1 ))

sleep 1;

done;
