#!/bin/bash

#---------------------------------------+
#Author:	Thiago Rinaldin Thomaz	|
#Data:		26/09/2017		|
#Requirement:	GNU-bash		|
#Version	0.1			|
#Use:		Used tp configure your	|
#		linux environment	|
#---------------------------------------+

#========== </variables> ================
version="0.1"
PROGRAM_LIST=( "apache2" "php" "mysql" )
APACHE_MODULES=( "mod_rewrite" )
PHP_MODULES=( "php_gd" "php_mysql" "php_pdo" "php_cli" )
command_list=$*

#========== </Functions> ================
_MENU() {
	clear

	echo "============================================="
	echo "Hello, $(whoami)"
	echo "Welcome to my environment configurator"
	echo "============================================="
	echo ""
	echo "I've seen that you're using:"
	lsb_release -a
	echo ""


	echo "This script will verify and install if it's necessary the following programs:"
	echo ""

	for PROGRAM in "${PROGRAM_LIST[@]}"; do
		echo " - $PROGRAM"
        done

	echo ""

	echo "Also that, it will enable the folowing modules:"
	echo " -- APACHE"

        for APACHE_MODULE in "${APACHE_MODULES[@]}"; do
                echo " ---- $APACHE_MODULE"
        done

	echo ""
        echo " -- PHP"

        for PHP_MODULE in "${PHP_MODULES[@]}"; do
                echo " ---- $PHP_MODULE"
        done


	echo ""
	echo ""
	echo ""
	echo -n "Would you like to install them?"
	echo ""
	echo "1 - Yes"
	echo "2 - No"
	echo "3 - Exit"

	read -n1 op
	case $op in
		1 ) _INSTALL;;
		2 ) echo "They wont be installed";;
		3 ) _EXIT;;
		* ) error;;
esac

}


function _command() {

	while [ "$command_list" ] 
	do
	        case $command_list in
        	        -h|--help) echo "Sorry I didn't write the help yet."; exit 0;;
	                -v|--version) shift; _version; exit 0;;
        	        *) error;;
	        esac
        	shift
	done

}

function _version() {
	echo ""
	echo "Environment: $version"
	echo "(c) 2017"
	echo ""
}

function error() {
	echo ""
	echo "Ops. Command not found."
	echo ""
	exit 1;
}

function _BACK() {
	echo ""
	echo "Would you like to go back to menu?"
	echo ""
        echo "1 - Yes"
        echo "2 - Exit"

        read op
        case $op in
                1 ) _MENU;;
                2 ) _EXIT;;
                * ) error;;
	esac


}

function _INSTALL() {
	echo "---------------------------"
	echo "Installing apache2"
	echo "---------------------------"
	echo ""
	sudo apt-get install apache2 apache2-utils
	echo ""

        echo "---------------------------"
        echo "Installing php"
        echo "---------------------------"
	echo ""
        sudo apt-get install php php-cli php-gd php-mysql
	echo ""

        echo "---------------------------"
        echo "Installing libapache2-mod-php"
        echo "---------------------------"
	echo ""
        sudo apt-get install libapache2-mod-php
	echo ""


	echo ""
        echo "---------------------------"
	echo "Restarting service: Apache "
        echo "---------------------------"



	echo ""
	echo ""
	echo ""
        echo "---------------------------"
        echo " - Done."
        echo "---------------------------"

	_BACK
}

function _EXIT() {
	echo "Hope that you have enjoyed it."
	sleep 3
	clear
	exit 0
}

#========== </Begin> ====================

[ "$1" ] && _command || _MENU;
#_MENU



#========== </End> ======================
