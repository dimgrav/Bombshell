# dispindex: A simple script to display directory contents
#
# Copyright 2017 (c) Dimitrios Gravanis
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# input:	user-specified path
# output:	path contents

#!/bin/bash

function index() {
	# check input
	read -p "directory path (q to quit): " FILEPATH
	cd $FILEPATH > /dev/null 2>&1
	while [ "$?" -ne "0" ]; do
		if [[ "$FILEPATH" = "q" || "$FILEPATH" = "Q" ]]; then
			echo "--stopped--"
			return 1
		else
			read -p "re-enter path (q to quit): " FILEPATH
		fi
		cd $FILEPATH > /dev/null 2>&1
	done
			
	# remove whitespace to get proper counts
	find -name "* *" -type d | rename 's/ /_/g'
	find -name "* *" -type f | rename 's/ /_/g'
	# count content types
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
	# restore whitespace
	find -name "*_*" -type d | rename 's/_/ /g'
	find -name "*_*" -type f | rename 's/_/ /g'

	# show contents
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
