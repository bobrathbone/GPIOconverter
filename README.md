RPi/GPIO.py
===========
**Version 2 - 21st January 2025** 

The GPIO.py code is primarialy for use with the Raspberry Pi Model 5 which uses the RP1 I/O chip.
It is also used for earlier models such as the 3B and 4B that are running *Bookworm*

It is designed to intercept traditional GPIO calls and convert them to LGPIO calls.
See: https://abyz.me.uk/lg/py_lgpio.html

OUTPUT: User Program --> GPIO calls --> GPIOconverter --> LGPIO

INPUT: LGPIO events --> GPIOconverter --> GPIO events --> User Program

Pre-requisites
=============
Install package python3-lgpio

sudo apt install python3-lgpio

Downloading GPIOconverter
========================
Log into the Raspberry Pi Model 5 and clone the GPIODconverter software and run:

git clone https://github.com/bobrathbone/GPIOconverter

Installation
============
Create a sub-directory called RPi in the directory where your GPIO code is installed
For example code in directory /usr/share/radio:

cd /usr/share/radio

mkdir RPi

cp \<source\>/GPIO.py /usr/share/radio/RPi/.

Note: The radiod package installation script has already done this

Enabling GPIO.py
================
For a Raspberry Pi model 5 only. Example:

touch /usr/share/radio/RPi/\_\_init\_\_.py

The instruction above will cause the code using the GPIO calls to see directory RPi as a package.

For earlier models such as the 3B or 4 disable the package

rm /usr/share/radio/RPi/\_\_init\_\_.py

Licensing
=========

*GPIOconverter* is released under the
[GNU General Public License version 2](https://www.gnu.org/licenses/gpl-2.0.txt),

Support
=======
It is not possible to provide support for GPIO.py as literally hundreds of thousands of programs
are using GPIO routines. The code is provided as is and without any warranties or "fit for purpose" etc.
Any issues reported should relate to this code only and not the functionality or logic of any GPIO code using it.

Bob Rathbone

https://bobrathbone.com
