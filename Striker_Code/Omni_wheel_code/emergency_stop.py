# Emergency Stop

import time
import pigpio
import lib_para_360_servo

# Define GPIO pins for each servo to write to
gpio_1 = 17
gpio_2 = 27
gpio_3 = 22

pi = pigpio.pi()

servo_1 = lib_para_360_servo.write_pwm(pi = pi, gpio = gpio_1)
servo_2 = lib_para_360_servo.write_pwm(pi = pi, gpio = gpio_2)
servo_3 = lib_para_360_servo.write_pwm(pi = pi, gpio = gpio_3)

#buffer time for initializing everything
time.sleep(1)

servo_1.set_speed(0)
servo_2.set_speed(0)
servo_3.set_speed(0)

pi.stop()
