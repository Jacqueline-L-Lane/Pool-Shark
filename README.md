# Pool Shark

### A Pool Playing Robot

UCLA MAE 162D/E Capstone Project

Created February 2020

### Observer Code:

1. Object_dection folder contains: 

	-Computer vision code and frozen inference graph 
	
	 Code borrowed from EdjeElectronics: https://github.com/EdjeElectronics/TensorFlow-Object-Detection-API-Tutorial-Train-Multiple-Objects-Windows-10

	-Training images

	-Testing images

2. client.py is one of two files that implement communication between the Observer and Striker raspberry pis via sockets

3. timeLapseVideo.sh is a simple script that takes a bunch of photos using the webcam to be used for training and testing

### Striker Code:

1. Omni_wheel_code folder contains omni wheel code including PI controllers

2. server.py is one of two files that implement communication between the Observer and Striker raspberry pis via sockets

3. run_pool_shark.py instructs the Striker to follow a pre-determined path and then wind the servo

4. pool_shark.service is a service to start run_pool_shark.py when the raspberry pi boots up
   
   Instructions on how to set up a service on raspberry pi: https://www.raspberrypi.org/documentation/linux/usage/systemd.md
