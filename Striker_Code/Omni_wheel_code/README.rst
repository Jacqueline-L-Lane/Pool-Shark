Omni Wheel Code
===============

Python 3 implementation for programming Parallax 360° continuous rotation servos with
a Raspberry Pi 4. The modules of the implementation are using the pigpio_ module 
to control the GPIOs of the Raspberry Pi. No other external module is needed.

About
-----

At the moment, the following functions are implemented:

* Turning on the spot
* Moving straight - forward and backward
* Scanning the surrounding with an ultrasonic sensor mounted on a servo

The turning and straight movements are controlled by six digital PID 
controllers. Each wheel is controlled by a cascade control, using 
a cascade of two PID controllers. The outer loops control the position 
while the inner loops control the speed of each wheel.

The modules provide simple APIs for turning and straight 
movements and also for scanning the surrounding or stearing a servo. Have a look 
at the Examples section of the documentation for some code examples.

Most of the default values in the modules are those which are used while 
experimenting/developing with the demo implementation. 

The modules also enable remote controlling the Raspberry Pis GPIOs. This enables 
use of the modules on a laptop/computer and over e.g. WLAN remote controlling the Raspberry Pi 
which provides a WLAN hotspot, see remote_pin_ and pi_hotspot_ . So, the robot can freely
move with a powerbank attached without any peripheral devices while programming/controlling it. 
The possibillity of remote controlling the Raspberry Pis GPIOs is a big advantage of the 
used pigpio_ module. This drastically improves the use of the modules, because then all 
programming/controlling can be done on a laptop/computer inlcuding using an IDE, having 
much more system ressources and so on. It is also possible to use the modules on the 
Raspberry Pi itself and connect to it over VNC, see VNC_ . For both ways, using the 
modules on the Raspberry Pi itself or remote on a laptop/computer to control the 
Raspberry Pis GPIOs, no modifications have to be done in the source code of the modules.


Documentation
-------------

Code borrowed from: https://360pibot.readthedocs.io/ .

