#!/bin/sh
# Prints the running glassfish domains, their pid, and the user id
# works on mac and linux (bsd and gnu)
#@author Carl-Erik Kopseng <carlerik@gmail.com>
#@date 2012-06-15

#sed_ERE_flag <none>
# returns the flag that enables extended regular expressions with this
# version of sed
function sed_ERE_flag() {
    GNU=$(sed --version 2>/dev/null)
    if [[ -n "$GNU" ]] ; then #GNU version
        echo "-r"
    else    #BSD sed
        echo "-E"
    fi
}

function print() {
    printf "%-15s %-6s %-s\n" $1 $2 $3
}

lines=$(ps  -A -o "ruser,pid,command" |grep domains|sed -n $(sed_ERE_flag) 's/([a-z_-]+)[ \t]+([0-9]+).*glassfish\/domains\/([a-z0-9]+).*/\3 \2 \1/p')

print DOMAIN PID USER
IFS=$'\n'
for line in $lines;  do
    domain=$(echo $line | cut -d' ' -f1)
    pid=$(echo $line | cut   -d' ' -f2)
    user=$(echo $line | cut  -d' ' -f3)

    print $domain $pid $user
done

