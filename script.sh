#!/bin/bash

#---------------------------------------+
#Author:	Thiago Rinaldin Thomaz	|
#Data:		26/09/2017		|
#Requirement:	GNU-bash		|
#Version	0.1			|
#---------------------------------------+

#========== </variables> ================

PROGRAM_LIST=( "apache2" "php" "mysql" )
APACHE_MODULES=( "mod_rewrite" )
PHP_MODULES=( "php_gd" "php_mysql" "php_pdo" "php_cli" )

#========== </Functions> ================

function _MENU() {

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
		* ) _MENU;;
esac

}

function _BACK() {
	echo ""
	echo "Would you like to go back to menu?"
	echo ""
        echo "1 - Yes"
        echo "2 - Exit"

        read -n1 op
        case $op in
                1 ) _MENU;;
                2 ) _EXIT;;
                * ) _MENU;;
	esac


}

function _INSTALL() {
	echo "---------------------------"
	echo "Installing apache2"
	echo "---------------------------"
	sudo apt-get install apache2 apache2-utils

        echo "---------------------------"
        echo "Installing php"
        echo "---------------------------"
        sudo apt-get install php php-cli php-gd php-mysql

        echo "---------------------------"
        echo "Installing libapache2-mod-php"
        echo "---------------------------"
        sudo apt-get install libapache2-mod-php


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

_MENU



#========== </End> ======================
