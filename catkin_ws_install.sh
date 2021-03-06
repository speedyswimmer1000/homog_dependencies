#! /bin/bash

COFF="\033[0m"
function red    { echo -e "\033[1;31m$@ ${COFF}"; }
function green  { echo -e "\033[1;32m$@ ${COFF}"; }
function yellow { echo -e "\033[1;33m$@ ${COFF}"; }
function blue   { echo -e "\033[1;34m$@ ${COFF}"; }
 
USER=`who | awk '{print $1}' | sort -u`
blue $HOME

cd $HOME

if [ $1 ]; then
	WORKSPACE=$1
else
	WORKSPACE="rel_nav_workspace"
fi

WORKSPACE_PATH=`pwd`/$WORKSPACE
ORIG_PATH=`pwd`
 
if [ ! -d /opt/ros/indigo ]; then
  red "Make sure you install ROS indigo first"
  exit 1
fi
source /opt/ros/indigo/setup.bash
 
### prepares catkin workspace with wstool, creates if doesn't exist
if [ ! -d "$WORKSPACE" ]; then
  yellow "$WORKSPACE does not exist!"
  yellow "initializing catkin workspace..."
  mkdir -p ${WORKSPACE_PATH}/src
  cd ${WORKSPACE_PATH}/src
  catkin_init_workspace
  catkin_make -C ../
  yellow "adding source setup.bash to .bashrc"
  
  echo "source ~/$WORKSPACE/devel/setup.bash" >> $HOME/.bashrc
  
  source $HOME/.bashrc
  
else
  yellow "$WORKSPACE exists!"  

  if cd ${WORKSPACE_PATH}/src; then
	yellow "Change directory to ${WORKSPACE_PATH}/src"
	cd ${WORKSPACE_PATH}/src
	if ! catkin_init_workspace 2>&1 | grep -q already; then
	  catkin_make -C ../
	  yellow "adding source setup.bash to .bashrc"
	  #echo "source $WORKSPACE_PATH/devel/setup.bash" >> ~/.bashrc
	  source ~/.bashrc     
	fi
  else
	yellow "Adding /src directory and catkinizing..."
	yellow "Change directory to $WORKSPACE/src"
	mkdir -p ${WORKSPACE_PATH}/src
	cd ${WORKSPACE_PATH}/src
	catkin_init_workspace
	catkin_make -C ../
	yellow "adding source setup.bash to .bashrc"
	#echo "source $WORKSPACE_PATH/devel/setup.bash" >> ~/.bashrc
	source ~/.bashrc
  fi


fi

chown $USER $HOME/$WORKSPACE/ -R

# Now I can cd into the source directory and work from there. 

