#!/bin/bash

# A small script to display directory contents
# Dimitrios Gravanis, 2017
# input:	user-specified path
# output:	path contents

function index() {
	read -p "Directory path: " FILEPATH
	echo "CONTENTS"
	cd $FILEPATH
	local COUNTF=0
	local COUNTD=0
	local COUNTU=0
	local COUNT=0
	local FILES=$(ls)
	
	for FILE in $FILES
	do
		if [ -d $FILE ]; then
			((COUNTD++))
		elif [ -f $FILE ]; then
			((COUNTF++))
		else
			((COUNTU++))
		fi
		((COUNT++))
	done
	
	echo "Total items:	${COUNT}"
	echo "Directories:	${COUNTD}"
	echo "      Files:	${COUNTF}"
	echo "Unspecified:	${COUNTU}"
}
index
if [ "$?" -eq "0" ]; then
	exit 0
else
	exit 1
fi
