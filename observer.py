# Observer Code

from detection import Detection
from multiprocessing import Process
import argparse
import base64
import cv2
import math
import numpy as np
import os
import pickle
import socket
import struct
import sys
import time
import zlib

#HOST = '192.168.1.101'  # change this to IP address of raspberry pi on striker

# Camera Calibration (performed once)
#def setup():

# Socket / zmq Communication stuff

def main():
    print("just to get this to compile")
    # setup()
    # Get initial frame from camera
    # Perform object detection on frame using TensorFlow (get bounding boxes -- start off simple)
        # Get coordinates for pockets (coordinates can be fixed)
        # Get coordinates for cue ball (keep track of where this is located!)
        # Get coordinates for all other object balls
        # Define boundary of pool table that the striker can maneuver in

    # count = 0
    # While there are still object balls on the table:
        # Step 1:
        # If count > 1
            # Get frame
            # Perform object detection on frame using Tensorflow (get bounding boxes -- start off simple)
                # Get coordinates for pockets (coordinates can be fixed)
                # Get coordinates for cue ball (keep track of where this is located!)
                # Get coordinates for all other object balls
                # Define boundary of pool table that the striker can maneuver in

        # Step 2:
        # TODO: Calculate trajectories for the cue and object balls and the force that needs to be applied

        # Step 3:
        # TODO: Translate trajectories into manageable commands that the striker can understand
            # Force -> Speed with which to hit the ball
            # Coordiantes of objects and paths -> control of the striker
            # TODO: how to deal with driving over object balls in the way?

        # Step 4:
        # Send command(s) to striker using sockets / zmq

        # Step 5:
        # Wait until observer has received confirmation from striker that command has successfully been executed

    # cleanup()

    # client_socket.close()


if __name__=='__main__':
    main()
