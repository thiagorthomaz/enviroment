#!/bin/bash

#---------------------------------------+
#Author:        Thiago Rinaldin Thomaz  |
#Data:          16/09/2017              |
#Requirement:   GNU-bash                |
#Version        0.1                     |
#Use:		This script is only to 	|
#		academic purpose.	|
#---------------------------------------+

clear

#source backup.conf
dir_from="home"
dir_to="tmp"

echo "============================================="
echo "Hello, $(whoami)"
echo "Welcome to my backup script"
echo "Be aware that it is academic, only to learn new commands."
echo ""
echo "This script will copy the following directories: $dir_from to $dir_to"
echo "============================================="


function _FULL_RECOVER () {
	destination="/tmp/full_bkp_recovered"
	[ ! -d $destination ] && mkdir -p $destination
	[ ! -d $destination ] && { echo "$(date): Impossible to create directory: $destination"; exit 1; }
	cd $destination
	cpio -idv --no-absolute-filenames < "/"$dir_to"/"$dir_from"_full.cpio"
}

function _FULL() {
	from="/$dir_from"
	to="/$dir_to/"$dir_from"_full.cpio"
	log="/$dir_to/"$dir_from"_full.log"
	echo ""
	echo "You selected the FULL bkp."
	echo "Copy from: $from"
	echo "Paste to: $to"
	echo "Log: $log"
	echo ""
	#find /home/ | cpio -ov > /tmp/bkp_full.cpio 2> /tmp/bkp_full.log
	# 2> redireciona a saída de erro para o arquivo de log
	# 1 já está implicito no >
	find $from | cpio -ov > $to 2> $log
}

function _INCREMENTAL(){
	echo ""
	echo "You selected the INCREMENTAL bkp."
        from="/$dir_from"
        to="/$dir_to/"$dir_from"_incremental.cpio"
        log="/$dir_to/"$dir_from"_incremental.log"
        echo ""
        echo "Copy from: $from"
        echo "Paste to: $to"
        echo "Log: $log"
        echo ""

	#rsync -rlXE --delete --log-file=/tmp/bkp_incremental.log /root/ /tmp/bkp_incremental
	rsync -rlXE --delete --log-file=$log $from $to

}

function _DIFFERENTIAL_RECOVER() {
	echo ""
	echo "Differential recover"
        #destination="/tmp/differential_bkp_recovered"
        #[ ! -d $destination ] && mkdir -p $destination
        #[ ! -d $destination ] && { echo "$(date): Impossible to create directory: $destination"; exit 1; }
        #cd $destination
	_FULL_RECOVER

        cpio -idv --no-absolute-filenames < "/"$dir_to"/"$dir_from"_differential.cpio"

}

function _DIFFERENTIAL() {

        from="/$dir_from"
        to="/$dir_to/"$dir_from"_differential.cpio"
	to_full="/$dir_to/"$dir_from"_full.cpio"
        log="/$dir_to/"$dir_from"_differential.log"
        echo ""
        echo "You selected the DIFFERENTIAL bkp."
        echo "Copy from: $from"
        echo "Paste to: $to"
        echo "Log: $log"
        echo ""

	#find /root -cnewer /tmp/bkp_full.cpio | cpio -ov > /tmp/bkp_diferencial.cpio 2> /tmp/bkp_diferencial.log
	find $from -cnewer $to_full | cpio -ov > $to 2> $log
}

function _EXIT() {
	clear
	echo ""
	echo "Bye"
	echo ""
	exit 1
}


echo ""
echo ""
echo "Which backup would you like to try?"
echo "1 - Full"
echo "2 - Incremental"
echo "3 - Differential"
echo "4 - Recover full bkp"
echo "5 - Recover differential bkp"
echo "0 - Exit"

read -n1 op
        case $op in
                1 ) _FULL;;
                2 ) _INCREMENTAL;;
                3 ) _DIFFERENTIAL;;
		4 ) _FULL_RECOVER;;
		5 ) _DIFFERENTIAL_RECOVER;;
                * ) EXIT;;
        esac


