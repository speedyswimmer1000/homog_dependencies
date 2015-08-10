#! /bin/bash

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

# Install packages for levmar, lapack, and homest.
'''
	apt-get install liblapack-dev --yes
	apt-get install libblas-dev checkinstall --yes
	apt-get install libblas-doc checkinstall --yes
	apt-get install liblapacke-dev checkinstall --yes
	apt-get install liblapack-doc checkinstall --yes
	apt-get install f2c --yes

	add-apt-repository --yes ppa:xqms/opencv-nonfree
	apt-get update
	apt-get install libopencv-nonfree-dev --yes

	echo "Making levmar..."

	cd levmar-2.6
	rm CMakeCache.txt
	cmake .
	make clean
	make

	echo "Copying levmar.h to /usr/local/include..."
	cp levmar.h /usr/local/include
	echo "Copying liblevmar to /usr/local/lib..."
	cp liblevmar.a /usr/local/lib

	echo "Starting to make homest..."

	cd ../homest-1.4
	rm CMakeCache.txt
	cmake .
	make clean
	make

	echo "Copying homest directory to /usr/local/include"
	cp ../homest-1.4/ /usr/local/include/ -r
	echo "Copying libhomest to /usr/local/lib"
	cp libhomest.a /usr/local/lib/
'''
# Now install database interface 

echo "Installing the database interface..." 

apt-get install ros-indigo-sql-database --yes
apt-get install pgadmin3 --yes
apt-get install postgresql --yes

echo "Cloning the homography git repos..."
cd ../.. # Going into catkin_ws/src directory
ls

if ! [ -d "homography_calc" ]; then
	git clone https://github.com/speedyswimmer1000/homography_calc.git
else
	echo "Homography_calc already exists..."
fi

chown $USER homography_calc -R

if ! [ -d "ROScamPub" ]; then
	git clone https://github.com/speedyswimmer1000/ROScamPub.git
else
	echo "ROS cam pub already exists..."
fi

chown $USER ROScamPub -R

if ! [ -d "ueyeROS" ]; then
	git clone https://github.com/speedyswimmer1000/ueyeROS.git
else
	echo "ueyeROS already exists..."
fi

chown $USER ueyeROS -R

echo "Going to make catkin_ws now..."
cd ..

# Got to source the catkin files.
source /opt/ros/indigo/setup.bash
source devel/setup.bash

catkin_make
chown $USER devel/ -R
chown $USER build/ -R
chown $USER src/ -R

cd src/ueyeROS/ueyeInstall
qmake .
make -j8
./install.run

CONFIG_DIR=`ps auwx | grep postgresql | grep -v grep | awk '{print $NF}' | sed 's/config_file=//' | sed 's/postgresql.conf//' | tail -n 1`

cp psqlConfig/* $CONFIG_DIR

service postgresql reload

apt-get install expect
# Currently in src/ueyeRos/ueyeInstall
cd ../../dependencies

# Call the script to create new users in the database.
# These users have root privileges, which is OK for what
# I'm doing. Root is going to install the databases.
su - postgres -c "$BASE_DIR/newUser.sh benjamin"
su - postgres -c "$BASE_DIR/newUser.sh $USER"
su - postgres -c "$BASE_DIR/newUser.sh root"

# Create the databases.

createdb ESM_KEYFRAMES
createdb FIND_MATCH_KEYFRAMES
createdb FIND_ONLY_KEYFRAMES

# Populate the databases with the tables we have saved

psql ESM_KEYFRAMES < databases/esm.db
psql FIND_MATCH_KEYFRAMES < databases/findMatch.db
psql FIND_ONLY_KEYFRAMES < databases/findOnly.db

../homography_calc/scripts/cleardatabase.sh

source ~/.bashrc

# Run the test script for the database setup, see
# if everything passes.
roslaunch homography_calc dbtest.launch | grep passed






