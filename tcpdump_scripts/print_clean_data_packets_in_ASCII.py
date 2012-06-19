#!/usr/bin/python
# -*- coding: UTF-8 -*-
# @author: Carl-Erik Kopseng
import sys
import re

length_of_tcp_packet = -1
combined_data = ""
for line in sys.stdin:
	pattern = '\d\d:\d\d:\d\d.*, length (\d+)'
	match = re.match(pattern, line)
	
        if match is None :
		if length_of_tcp_packet <= 0:
			continue
		combined_data += "" + line
	else:
		sys.stdout.write( combined_data[-(length_of_tcp_packet+1):-1] )

		length_of_tcp_packet = int(match.group(1))
		combined_data = ""

sys.stdout.write( combined_data ) 
