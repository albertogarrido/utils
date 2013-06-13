#!/bin/bash

# Init
FILE="/tmp/out.$$"
GREP="/bin/grep"
#....
# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ $# -gt 1 ]; then
	echo " # ERROR: Too many parameters"
	exit 0
else if [ $# -lt 1 ]; then
		echo " # ERROR: You must specify the project to install"
		exit 0
	fi
fi

PROJECT=$1
TEMP_WP_DIR=/tmp/wp
SERVER_DIR=/Library/WebServer/Documents

echo "Checking previous instalations... "
if [ -d $SERVER_DIR/$PROJECT ]; then
	echo " # ERROR: This project exists already. Try another name"
	exit 0
else
	mkdir $SERVER_DIR/$PROJECT
fi

echo "Creating temp directory ... "

if [ ! -d $TEMP_WP_DIR ]; then
	mkdir -p $TEMP_WP_DIR
else
	touch $TEMP_WP_DIR/a
	rm -r $TEMP_WP_DIR/*
fi

cd $TEMP_WP_DIR

echo "Downloading latest version of wordpress ... "

curl -O http://wordpress.org/latest.zip > /dev/null 2> wp_install_log.txt

echo "Unziping wordpress ... "

unzip $TEMP_WP_DIR/latest.zip > /dev/null 2> wp_install_log.txt

echo "Installing Wordpress..."

mv wordpress/* $SERVER_DIR/$PROJECT



#CREATING DATABASE
#echo "create database $PROJECT" | mysql -u root