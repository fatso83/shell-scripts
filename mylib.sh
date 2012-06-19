#abspath: returns the absolute path of a file or directory
#Expects an existing file string as argument. Error on non-existing file
#Works on Mac and Linux (GNU Bash 3+)
#@author:  Stephanus Paulus Arif Sahari Wibowo 
#retrieved from
#http://www.linuxquestions.org/questions/programming-9/bash-script-return-full-path-and-filename-680368/page3.html#post4309783 (2011-03-31)
#on 2012-06-19
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
