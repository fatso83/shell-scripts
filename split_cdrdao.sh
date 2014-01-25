#!/bin/bash
# Purpose: Split flac-encoded backups made by cdrdao into easy-to-use,
# individual tracks, tagged with artist, album and other metadata.
# 
# (It is very easy to modify this script to use the normal image files 
# produced by cdrdao. Drop me a note if that would be interesting)
#
# Prerequisites: 
# - a folder containing other folders, each having a single flac file and a 
# corresponding toc file (made by the CDRDAO program).
# - The `toc2cue` program
# - The python lib/program `audiotools`
#
# Use:
# Just change the three parameters to suit your system and execute the 
# script by writing `./split_cdrdao.sh`


# the directory where the cdrdao copies lie
INPUT_DIR=/home/carl-erik/cdrdao.albumbackup
# the directory where the folders containing the split tracks end up
OUTPUT=/mnt/data/cdrdao-split

# where to put the folders once they have been converted/split up into individual tracks
CONVERTED=/mnt/data/converted

pushd $INPUT_DIR
mkdir $CONVERTED 2>/dev/null

basedir=$PWD; 
echo Starting in $basedir > /tmp/dao-conversion.status
for dir in *; do 
	echo $dir >> /tmp/dao-conversion.status

	# use full path in case something goes wrong half way
	cd "${basedir}/${dir}"; 
	toc2cue *toc out.cue; 
	tracksplit -t flac  \
		--cue=out.cue *.flac  -j2 -D -d "$OUTPUT/$dir" \
		--replay-gain \
		"--format=%(track_number)2.2d - %(album_name)s - %(track_name)s.%(suffix)s"; 
	rm out.cue
	cd $basedir; 
	mv "${dir}" "${CONVERTED}"/
done

echo Finished >> /tmp/dao-conversion.status
popd
