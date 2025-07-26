#!/usr/bin/env python3
#
# Raspberry Pi RPi.GPIO interception package
# $Id: test_group.py,v 1.4 2025/02/16 09:25:02 bob Exp $
#
# Author : Bob Rathbone
# Site   : http://www.bobrathbone.com
#
# This package intercepts RPi.GPIO calls and redirects them to the lgpio package
# calls specifically used for the Raspberry Pi model 5 or Bookworm
# See: https://abyz.me.uk/lg/py_lgpio.html
#
# This test program tests both a single GPIO or a GPIO group
#
# License: GNU V3, See https://www.gnu.org/copyleft/gpl.html
#
# Disclaimer: Software is provided as is and absolutly no warranties are implied or given.
#         The authors shall not be liable for any loss or damage however caused.
#

import RPi.GPIO as GPIO 
import time

# Mode is either GPIO.BCM or GPIO.BOARD
mode = GPIO.BCM     # Default
# Uncomment below to test mode GPIO.BOARD
#mode = GPIO.BOARD

# Change the following values to suit your system
led=16          # Led GPIO for mode BCM
led_board = 36  # Led GPIO for mode BOARD
chan_list = [18,16,17,4]        # Group GPIOs for mode BCM
chan_list_board = [12,36,11,7]  # Group GPIOs for mode BOARD

values1 = [1,0,1,0]     
values2 = [0,1,0,1]

print("Single GPIO and GPIO group test")

if mode is GPIO.BCM:
    print("GPIO mode GPIO.BCM (%d)" % GPIO.BCM)
    GPIO.setmode(GPIO.BCM)
elif mode is GPIO.BOARD:
    print("GPIO mode GPIO.BOARD (%d)" % GPIO.BOARD)
    GPIO.setmode(GPIO.BOARD)
    chan_list = chan_list_board
    led = led_board

GPIO.setup(chan_list,GPIO.OUT)

# Test single GPIO
count = 5
print("Test single LED", led)
while count > 0:
    GPIO.output(led,GPIO.HIGH)
    time.sleep(1)
    GPIO.output(led,GPIO.LOW)
    time.sleep(1)
    count -= 1

# Test a group of GPIOs
print("Test GPIO group", chan_list)
count = 10
while count > 0:
    GPIO.output(chan_list,values1)
    time.sleep(0.3)
    GPIO.output(chan_list,values2)
    time.sleep(0.3)
    count -= 1

# Switch off all LEDs
#GPIO.output(chan_list,[0,0,0,0])
GPIO.cleanup(chan_list)

print("End of test")

# set tabstop=4 shiftwidth=4 expandtab
# retab
