#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root or with sudo" 1>&2
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
DB_USER=root
DB_PASS=''

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

echo "Creating database $PROJECT ..."
echo "create database $PROJECT" | mysql -u root

cd $SERVER_DIR/$PROJECT

cp wp-config-sample.php wp-config.php

WPDBNAME=`cat wp-config.php | grep DB_NAME | cut -d \' -f 4`
WPDBUSER=`cat wp-config.php | grep DB_USER | cut -d \' -f 4`
WPDBPASS=`cat wp-config.php | grep DB_PASSWORD | cut -d \' -f 4`

echo "Configuring wordpress... "

perl -pi -e "s/$WPDBNAME/$PROJECT/g" wp-config.php
perl -pi -e "s/$WPDBUSER/$DB_USER/g" wp-config.php
perl -pi -e "s/$WPDBPASS/$DB_PASS/g" wp-config.php

touch .htaccess
chmod 777 .htaccess 

cd wp-content
mkdir -p uploads
chmod 777 uploads
cd ..

echo "Launching in browser... "
open http://localhost/$PROJECT

#cleaning temp dir
rm -r $TEMP_WP_DIR/*
