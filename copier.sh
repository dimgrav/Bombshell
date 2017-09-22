# copier: A simple script to copy entire directory contents
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
# output:	source path contents

#!/bin/bash

function copier() {
	# check directory path input
	read -p "path to files to be copied (q to quit): " FILEPATHSRC
	if [[ "$FILEPATHSRC" = "q" || "$FILEPATHSRC" = "Q" ]]; then
		echo "--stopped--"
		return 1
	fi

	cd $FILEPATHSRC
	while [[ "$?" -ne "0" ]]; do
		read -p "re-enter a valid path (q to quit): " FILEPATHSRC
		cd $FILEPATHSRC
	done

	read -p "path to destination directory: " FILEPATHDST
	if [[ "$FILEPATHDST" = "q" || "$FILEPATHDST" = "Q" ]]; then
		echo "--stopped--"
		return 1
	fi
	
	cd $FILEPATHDST
	while [[ "$?" -ne "0" ]]; do
		read -p "re-enter a valid path (q to quit): " FILEPATHDST
		cd $FILEPATHDST
	done
	
	# create file list
	cd $FILEPATHSRC
	local FILES=$(ls)

	for FILE in $FILES; do

		# rename dirs/files to remove whitespace
		find -name "* *" -type d | rename 's/ /_/g'
		find -name "* *" -type f | rename 's/ /_/g'

		cp -R $FILE $FILEPATHDST
	done

	return 0
}

while [ true ]; do
	copier
	if [ "$?" -ne "0" ]; then
		break
		exit 1
	fi
done
