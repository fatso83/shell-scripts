#!/bin/bash
EXTRA_ARGS=""

usage() {
	echo "Example: $0 <dst ip> [src ip] <port>"
	exit 1
}

if (( $# < 2 )); then
	usage
fi

if (( $# == 2 )); then
	DST=$1
	PORT=$2
fi

if (( $# == 3 )); then
	DST=$1
	EXTRA_ARGS="and src $2"
	PORT=$3
fi

OUTPUT_FILE="-" #STDOUT
tcpdump -A -s 0 -w $OUTPUT_FILE  "dst $DST and port $PORT $EXTRA_ARGS" 
