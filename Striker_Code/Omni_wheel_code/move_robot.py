# Move Robot (Striker)

import pigpio
import lib_motion

pi = pigpio.pi()

robot = lib_motion.control(pi = pi)

a = 0
while a < 4:
    robot.turn(45)
    a+=1

robot.straight(200)
robot.straight(-200)

a = 0
while a < 2:
    robot.turn(-90)
    a+=1

robot.cancel()

pi.stop()
