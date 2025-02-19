#!/bin/bash
# $Id: build.sh,v 1.3 2025/02/19 14:29:37 bob Exp $
# Build script for the Raspberry GPIOconverter shim 
# Run this script as  a regular user and not root

PKGDEF=gpioconverter
PKG=gpioconverter
VERSION=$(grep ^Version: ${PKGDEF} | awk '{print $2}')
BUILDLOG=build.log
OS_RELEASE=/etc/os-release
EQUIVS=/usr/bin/equivs-build

# Colours
orange='\033[33m'
blue='\033[34m'
green='\033[32m'
default='\033[39m'

# Check we are not running as sudo
if [[ "$EUID" -eq 0 ]];then
    echo "Run this script as user ${USR} and not sudo/root"
    exit 1
fi

echo "Building ${PKG} package $(date)"

DEBPKG=${PKG}_${VERSION}_all.deb
echo "Buiding ${DEBPKG}"

# Get architecture
BIT=$(getconf LONG_BIT)     # 32 or 64-bit archtecture
if [[ ${BIT} == 64 ]];then
    ARCH=arm64
else
    ARCH=armhf
fi

# Temporary target directory
##sudo mkdir -p /home/pi/usr/lib/python3/dist-packages/

echo "Building package ${PKG} version ${VERSION} Architecture ${BIT}-bit" | tee ${BUILDLOG}
echo "from input file ${PKGDEF}" | tee -a ${BUILDLOG}
sudo chown  ${USR}:${GRP} RPi/*.py
sudo chmod  +x RPi/*.py
sudo chmod  -x RPi/__init__.py


if [[ ! -f ${EQUIVS} ]];then
    sudo apt-get -y install equivs apt-file lintian
fi

# Build the package
equivs-build ${PKGDEF} | tee -a ${BUILDLOG}

echo -n "Check using Lintian y/n: "
read ans
if [[ ${ans} == 'y' ]]; then
    echo "Checking package ${DEBPKG} with lintian"  | tee -a ${BUILDLOG}
    lintian ${DEBPKG} | tee -a ${BUILDLOG}
    if [[ $? = 0 ]]
    then
        echo "Package ${DEBPKG} OK" | tee -a ${BUILDLOG}
        echo "See ${BUILDLOG} for build details"
        echo "Package ${DEBPKG} file list" >> ${BUILDLOG}
        dpkg -c ${DEBPKG} >> ${BUILDLOG}
    else
        echo "Package ${DEBPKG} has errors" | tee -a ${BUILDLOG}
    fi
fi

# Display contents
dpkg --contents ${DEBPKG}

echo
echo "Now install the ${DEBPKG} package with the following command:"
printf $orange
echo "sudo dpkg -i ${DEBPKG}"
printf $default

# End of build script

