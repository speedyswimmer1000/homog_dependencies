#! /bin/bash

# Reasonable assumption: Running ubuntu 14.04 or later.

REPLY=`whoami`

SCRIPT_DIR=`dirname $0`

USER=`who | awk '{print $1}' | sort -u`

# Directory this script is located in.
BASE_DIR=`pwd`

# TODO: Variable for this directory as the base station

if ! [ $REPLY == 'root' ]; then
	echo "You are not sudo. Please run as sudo."
	exit
fi

sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
apt-key adv --keyserver hkp://pool.sks-keyservers.net --recv-key 0xB01FA116

apt-get update

sudo apt-get install ros-indigo-desktop-full -y

su $USER -c 'rosdep init >/dev/null'
su $USER -c 'rosdep update'

