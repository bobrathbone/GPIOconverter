GPIOconverter package
=====================

## RPi/GPIO.py

Version 1.0 - 18th February 2025

**GPIOconverter** is a so-called **software shim** and is primarly for use with the **Raspberry Pi Model 5**
computer and for earlier models such as the **Model 3B** or **4B** that are running **Bookworm OS**.
Legacy **RPi.GPIO** calls do not work on the the Raspberry Model 5 as it now 
has a separate chip called **RP1** for controlling I/O including the pins on the GPIO header (j8).
Also the new **RPi/GPIO package** on Bookworm that is meant to be used but at the time of writing does not 
work on the **32-Bit version**. The **64-bit** version of **Bookworm** works fine. This will no doubt change in
the future. **GPIO.py** is the program which carries out the conversion.

**GPIOconverter** is designed overcome these problems and it works by intercepting **RPi.GPIO** calls and converts them to **LGPIO** calls.
See: https://abyz.me.uk/lg/py_lgpio.html

```
OUTPUT: User Program --> GPIO calls --> GPIOconverter --> LGPIO 
INPUT: LGPIO events --> GPIOconverter --> GPIO events --> User Program
```
Installing the ready made GPIOconverter package
===============================================
You can install the ready made package from the [https://bobrathbone.com](https://bobrathbone.com) Web site.
Log into your Raspberry Pi and run the following.
```
sudo apt install python3-lgpio
curl -L -O https://bobrathbone.com/raspberrypi/packages/gpioconverter_1.0_all.deb
sudo dpkg -i gpioconverter_1.0_all.deb
```
**Note:**  The **GPIOconverter** package can only be installed on Bookworm OS or later.

Building the GPIOconverter package
==================================
The software is installed from the GPIOconverter package. To build it carry out the following procedure:

## Install the python3-lgpio package
The **GPIOconverter** package requires the **python3-lgpio** module. Log into the Raspberry Pi and install the **python3-lgpio** package
```
sudo apt install python3-lgpio
```
## Downloading GPIOconverter from GitHub
Now clone the GPIOconverter software to your home directory and run:
```
cd
git clone https://github.com/bobrathbone/GPIOconverter
```
## Build the GPIOconverter package
```
cd GPIOconverter
chmod +x setup.sh
./setup.sh
```

The **setup.sh** script will now install the necessary build tools (**equivs apt-file** and **lintian**) and then 
create the **GPIOconverter** package by running the **build.sh** script.
Towards the end of the build you will be asked if you wish to check the package with Lintian. 
This is only used by developers so - Answer n 
```
Check using Lintian y/n: n
```
The package definition will be found in the **gpioconverter** file.
## Installing the GPIOconverter package
At the end of the run the build script will display the instruction to install the package using **dpkg** installer
as shown below.
```
Install the gpioconverter_1.0_all.deb package with the following command:
sudo dpkg -i gpioconverter_1.0_all.deb
```
## Subsequent package builds
The **setup.sh** script only needs to be run once. Run **build.sh** directly for all subsequent builds.
```
cd GPIOconverter
./build.sh
```
Installation to a local directory
=================================
It may well be that you only wish to install the package **GPIOconverter** software in a specific project directory
leaving the rest of the system unaffected. If so you do not need to create the package but only copy the main files to your project directory. 
Create a sub-directory called RPi in the directory where your GPIO code is installed
For example code in directory **/usr/share/myproject**:
```
cd /usr/share/myproject
mkdir RPi
cp /home/<user>/GPIOconverter/RPi/GPIO.py /usr/share/myproject/RPi/.
```
Where \<user\> is your log in name (usually 'pi')

## Enabling GPIO.py
If running on a **Raspberry Pi model 5** or if running **Bookworm (32-bit)** or later. Example:
```
touch /usr/share/myproject/RPi/__init__.py
```
The above instruction will cause the code using the GPIO calls to see directory **RPi** as a package.
For earlier models such as the 3B or 4 disable the package unless running on **Bookworm 32-bit OS** using
the instruction below:
```
rm /usr/share/myproject/RPi/__init__.py
```
## test_group.py
The **test_group.py** program is a simple test program used to test the **RPi.GPIO group** functions. 
First edit the **test_group.py** file and change the list of GPIOs in **chan_list** to change the GPIO list that you are using for the test and the single LED GPIO 
```
chan_list = [18,16,17,4]        # Group GPIOs
led = 16   # Led GPIO for mode BCM 
```
The program first flashes a single LED as configured by the **led** parameter and then switches alternate LEDs defined in **chan_list**  

## test_pym.py
The **test_pym.py** program is used to test the **PWM** (Pulse Width Modulation) function of **RPi.GPIO**. 
First edit the **test_pwm.py** file and change the led GPIO setting to the the GPIO number you are using for the test.
```
led = 16
```
Now run the program. The selected LED should brighten and dim. Press Ctrl-C to end the test. 
```
cd /usr/share/myproject/RPi
./test_pwm.py
```
**Note:** If you are only using **GPIOconverter** in a local project directory then it is necessary to first copy 
**test_pwm.py** to it and run it from there as shown in the following example.
```
cd /usr/share/myproject
cp RPi/test_pwm.py .
./test_pwm.py
```
The above is not necessarry if you installed the **GPIOconverter** package as previously shown.

Uninstalling GPIOconverter
=========================
Run the following instruction:
```
sudo dpkg -r gpioconverter
```
Now restore the standard **RPi.GPIO library**
```
sudo mv /usr/lib/python3/dist-packages/RPi_standard /usr/lib/python3/dist-packages/RPi
```
Licensing
=========
*GPIOconverter* is released under the
[GNU General Public License version 3](https://www.gnu.org/licenses/gpl-3.0.en.html)

Support
=======
Although it is not possible to provide support for **GPIO.py** as literally hundreds of thousands of programs
are using GPIO routines, you can raise an issue in **GitHub** if you think that there is a problem with this software. 
The code is provided as is and without any warranties or "fit for purpose" etc. Participation in this project is welcome.

**Bob Rathbone**

[https://bobrathbone.com](https://bobrathbone.com)
