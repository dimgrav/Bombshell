#!/bin/bash

# A simple script to display directory contents
# Dimitrios Gravanis, 2017
# input:	user-specified path
# output:	path contents

function index() {
	read -p "directory path (q to quit): " FILEPATH
	if [[ "$FILEPATH" = "q" || "$FILEPATH" = "Q" ]]; then
		echo "--stopped--"
		return 1
	fi

	cd $FILEPATH
	while [ "$?" -ne "0" ]; do
		read -p "re-enter path (q to quit): " FILEPATH
		cd $FILEPATH
	done
			
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
	echo "CONTENTS"
	echo "--------"
	echo "total items: ${COUNT}"
	echo "directories: ${COUNTD}"
	echo "      files: ${COUNTF}"
	echo "unspecified: ${COUNTU}"
	echo "--------"
	return 0
}

while [ true ]
do
	index
	if [ "$?" -ne "0" ]; then
		break
		exit 1
	fi
done