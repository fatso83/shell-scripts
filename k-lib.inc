#KLib - a collection of bash utility functions
# GitHub: https://github.com/fatso83/shell-scripts.git
# @see README for more info

#abspath <a file or directory>
# returns the absolute path of a file or directory
# Expects an existing file string as argument. Error on non-existing file
# Works on Mac and Linux (GNU Bash 3+)
# @author:  Stephanus Paulus Arif Sahari Wibowo 
# retrieved from http://www.linuxquestions.org/questions/programming-9/bash-script-return-full-path-and-filename-680368/page3.html#post4309783
# Retrieve date:    2012-06-19
# Post date:        2011-03-31
function abspath {
	if [[ -d "$1" ]]
	then
		pushd "$1" >/dev/null
		pwd
		popd >/dev/null
	elif [[ -e $1 ]]
	then
		pushd $(dirname $1) >/dev/null
		echo $(pwd)/$(basename $1)
		popd >/dev/null
	else
		echo $1 does not exist! >&2
		return 127
	fi
}

#debugprintf <format string> [[argument1] ...]
# to stderr if $DEBUG is defined
# @see printf(1)
function debugprintf() {
	if [[ -n $DEBUG ]]; then
            format_string="$1"
            shift 1
            printf "$format_string" $@ > /dev/stderr
}

#debug_tee <none>
# pipes all input to stderr as well as stdout if $DEBUG is a non-zero string. 
# in case DEBUG is not defined, the output is simple piped to stdout (no side-effect)
function debug_out() {
	if [[ -n $DEBUG ]] ;then 
		tee /dev/stderr
	else
		cat
	fi
}

