# Calibrate

import time
import pigpio
import lib_para_360_servo

# Define GPIO for each servo to read from
gpio_1_r = 16      # servo 1
gpio_2_r = 20      # servo 2
gpio_3_r = 21      # servo 3

# Define GPIO for each servo to write to
gpio_1_w = 17
gpio_2_w = 27
gpio_3_w = 22

pi = pigpio.pi()

#### Calibrate servos, speed  = 0.2 and -0.2
servo = lib_para_360_servo.write_pwm(pi = pi, gpio = gpio_1_w)            # do 1, 2, and 3

# Buffer time for initializing everything
time.sleep(1)
servo.set_speed(0.2)                                                      # do 0.2 and -0.2
wheel = lib_para_360_servo.calibrate_pwm(pi = pi, gpio = gpio_1_r)        # do 1, 2, and 3

servo.set_speed(0)

pi.stop()
