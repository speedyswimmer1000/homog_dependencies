#uninstall 

#! /bin/bash

cd $HOME

if [ $1 ]; then
	WORKSPACE=$1
else
	exit
fi

echo $WORKSPACE

sed -i /$WORKSPACE'\/devel\/setup.bash'/d ~/.bashrc  # Remove that line from the .bashrc 

rm -rf $WORKSPACE
