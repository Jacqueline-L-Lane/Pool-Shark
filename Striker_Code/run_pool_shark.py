# Import libraries
import RPi.GPIO as GPIO
import time

# Set GPIO numbering mode
GPIO.setmode(GPIO.BOARD)

# Set pins 11 & 12 as outputs, and define as PWM servo1 & servo2
GPIO.setup(11,GPIO.OUT)
servo1 = GPIO.PWM(11,50) # pin 11 for servo1
GPIO.setup(15,GPIO.OUT)
servo2 = GPIO.PWM(15,50) # pin 12 for servo2
GPIO.setup(13,GPIO.OUT)
servo3 = GPIO.PWM(13,50) # pin 13 for servo3
GPIO.setup(31,GPIO.OUT)
servo = GPIO.PWM(31,50) # Note 31 is pin, 50 = 50Hz pulse frequency

# Start PWM running on both servos, value of 0 (pulse off)
servo1.start(0) 
servo2.start(0)
servo3.start(0) 

# Rotate around in a circle:
servo1.ChangeDutyCycle(2.5) # [2.5, 7] -> rotate clockwise
servo2.ChangeDutyCycle(2.5) # [2.5, 7] -> rotate clockwise
servo3.ChangeDutyCycle(2.5)
time.sleep(3)
servo1.ChangeDutyCycle(11.5) # [7.3, 12] -> rotate counterclockwise
servo2.ChangeDutyCycle(11.5)
servo3.ChangeDutyCycle(11.5)
time.sleep(3)

servo3.stop()

# Move to cue ball:
servo1.ChangeDutyCycle(2.5) # [2.5, 7] -> rotate clockwise
servo2.ChangeDutyCycle(11.5) # [2.5, 7] -> rotate clockwise
time.sleep(1) 
servo1.ChangeDutyCycle(2.5) # [7.3, 12] -> rotate counterclockwise
time.sleep(0.2)
servo1.stop()
servo2.start(0)
servo2.ChangeDutyCycle(11.5)
time.sleep(1.5)
servo2.ChangeDutyCycle(7.5)
time.sleep(1)
servo2.stop()


###### Kick Ball #######
# Set pin 31 as an output, and set kicker servo as pin 31 as PWM

#start PWM running, but with value of 0 (pulse off)
servo.start(0)
print ("Waiting for 2 seconds")
time.sleep(2)

#Let's move the servo!
print ("Rotating 90 degrees counterclockwise and then 90 degrees clockwise")  # 10 steps

# Define variable duty
duty = 5       # ORIGINAL: 5

# Loop for duty values from 2 to 12 (0 to 180 degrees)
servo.ChangeDutyCycle(duty)
time.sleep(3)   # ORIGINAL: 3, 1
servo.ChangeDutyCycle(9)
time.sleep(3)

# To test that the third (idler gear) can re-engage properly, uncomment these lines:
#time.sleep(1) 
#servo.ChangeDutyCycle(4)
#time.sleep(1) 

#Clean things up at the end
servo.stop()

#Clean things up at the end
servo1.stop()
servo2.stop()
#servo3.stop()
GPIO.cleanup()

print ("Goodbye")
