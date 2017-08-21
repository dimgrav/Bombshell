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
