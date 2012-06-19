#!/bin/bash
#@author:	carlerik <at> gmail.com
#@date: 	2011-04-12 20:28

if [[ ! -e $JAVA_HOME/bin/java ]] ; then 
	JAVA_HOME="/etc/java-config-2/current-system-vm"
fi

JSTAT="$JAVA_HOME"/bin/jstat

usage() {
	echo "Print memory usage of a currently running glassfish instance"
	echo "Usage: $0 [--datetime] <glassfish domain>"
	echo "Options: "
	echo -e "\t --help This help message"
	echo -e "\t --datetime print the date and time"
	echo -e "\nRefer to the manual on Oracle's pages for what the various acronyms mean:"
	echo "http://download.oracle.com/javase/1.5.0/docs/tooldocs/share/jstat.html#gc_option"
	exit 1
}

check_args() {
	if (($# < 1)); then
		usage
	fi

	if [[ x"$1" == x"--help" ]]; then
		usage
	fi

	#if two arguments, check that the first is --datetime option
	if (($# == 2)); then

		if [[ x"$1" != x"--datetime" ]]; then
			usage
		fi
	fi
}

check_jstat() {
	if [[ ! -e $JSTAT ]]; then
		echo "Found no jstat executable in \$JAVA_HOME=$JAVA_HOME. Quitting ..."
		exit 1
	fi
}

check_glassfish() {
	PID=$1
	if [[ x$PID == x ]] ; then
		echo "Found no running glassfish instance with domain $DOMAIN"
		exit 1
	fi
}

check_args $@
check_jstat

#print date and time, if applicable
if [[ x"$1" == x"--datetime" ]]; then
	date +"%F %T"
	shift 1 #shift the arguments left, so that $2 becomes $1
fi

DOMAIN=$1

#must remove the command itself from the grep hits
PID=$(ps aux|grep -- "$DOMAIN"|grep -v $0|grep -v grep|awk '{print $2}')

check_glassfish $PID

#get memory stats
"$JSTAT" -gc $PID
