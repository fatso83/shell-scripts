#!/bin/bash
if (( $# > 0 )); then
	tcpdump -s0 -A -r $@
else
	tcpdump -s0 -A -r -
fi
