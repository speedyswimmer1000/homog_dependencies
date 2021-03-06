#! /bin/bash

# OpenCV installation, including nonfree.

# Works on a system with OpenCV installed already.
# On a new system, OpenCV probably is already installed by ROS first (in my script)
# Works on new system. 

REPLY=`whoami`

SCRIPT_DIR=`dirname "$(readlink -f "$0")"`

USER=`who | awk '{print $1}' | sort -u`

# Directory this script is located in.
BASE_DIR=`pwd`

# TODO: Variable for this directory as the base station

if ! [ $REPLY == 'root' ]; then
	echo "You are not sudo. Please run as sudo."
	exit
fi

# Directions from the OpenCV website for Ubuntu.
apt-get install build-essential -y
apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev -y 
apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev -y

# Install the nonfree repository
add-apt-repository --yes ppa:xqms/opencv-nonfree
apt-get update
apt-get install libopencv-nonfree-dev --yes
