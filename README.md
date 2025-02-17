GPIOconverter package
=====================

## RPi/GPIO.py

Version 1.0 - 17th February 2025

The GPIO.py code is primarly for use with the Raspberry Pi Model 5 qand
for earlier models such as the Model 3B or 4 that are running Bookworm OS

It is designed to intercept GPIO calls and convert them to LGPIO calls.
See: https://abyz.me.uk/lg/py_lgpio.html

```
OUTPUT: User Program --> GPIO calls --> GPIOconverter --> LGPIO 
INPUT: LGPIO events --> GPIOconverter --> GPIO events --> User Program
```

Building the GPIOconverter package
===============================
The software is installed from the GPIOconverter package. To build it carry out the following procedure:

## Install the python3-lgpio package
Log into the Raspberry Pi and install the python3-lgpio package
```
sudo apt install python3-lgpio
```
## Downloading GPIOconverter from GitHub
Now clone the GPIOconverter software and run:
```
git clone https://github.com/bobrathbone/GPIOconverter
```
## Build the GPIOconverter package
```
cd GPIOconverter
chmod +x build.sh
./build.sh
```

The build script will now create the **GPIOconverter package**
At the end of the build you will be asked if you wish to check the package with Lintian - Answer n 
```
Check using Lintian y/n: n
:
```
## Installing the GPIOconverter package
```
Now install the gpioconverter_1.0_all.deb package with the following command:
sudo dpkg -i gpioconverter_1.0_all.deb
```
Installation to a local directory
=================================
It may well be that you only wish to install the package GPIOconverter packafge in a specific project directory.
If so you do not need to create the pakage but only copy the main files to your project directory. 
Create a sub-directory called RPi in the directory where your GPIO code is installed
For example code in directory **/usr/share/myproject**:
```
cd /usr/share/myproject
mkdir RPi
cp <source>/RPi/GPIO.py /usr/share/myproject/RPi/.
```

## Enabling GPIO.py
Only if using a Raspberry Pi model 5 or if running Bookworm or later. Example:
```
touch /usr/share/myproject/RPi/__init__.py
```

The above instruction will cause the code using the GPIO calls to see directory **RPi** as a package.

For earlier models such as the 3B or 4 disable the package unless running on **Bookworm OS**
```
rm /usr/share/rmyproject/RPi/__init__.py
```

Licensing
=========
*GPIOconverter* is released under the

[GNU General Public License version 3](https://www.gnu.org/licenses/gpl-3.0.en.html)

Support
=======
It is not possible to provide support for GPIO.py as literally hundreds of thousands of programs
are using GPIO routines. The code is provided as is and without any warranties or "fit for purpose" etc.

**Bob Rathbone**

[https://bobrathbone.com](https://bobrathbone.com)
