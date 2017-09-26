# easycp: A simple script to copy entire directory contents
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

declare FILEPATHSRC
declare FILEPATHDST

function setpaths() {
	# source directory
	read -p "path to file source directory (q to quit): " FILEPATHSRC
	if [[ "$FILEPATHSRC" = "q" || "$FILEPATHSRC" = "Q" ]]; then
		echo "--stopped--"
		return 1
	fi

	cd $FILEPATHSRC > /dev/null 2>&1
	while [[ "$?" -ne "0" ]]; do
		read -p "re-enter a valid path (q to quit): " FILEPATHSRC
		cd $FILEPATHSRC > /dev/null 2>&1
	done
	# target directory
	read -p "path to file destination directory (q to quit): " FILEPATHDST
	if [[ "$FILEPATHDST" = "q" || "$FILEPATHDST" = "Q" ]]; then
		echo "--stopped--"
		return 1
	fi
	cd $FILEPATHDST > /dev/null 2>&1
	while [[ "$?" -ne "0" ]]; do
		if [[ ! -e $FILEPATHDST ]]; then
			mkdir -p $FILEPATHDST
		elif [[ ! -d $FILEPATHDST ]]; then
			echo "non-directory item exists at the given path!"
			read -p "re-enter a valid path (q to quit): " FILEPATHDST
		fi
		cd $FILEPATHDST > /dev/null 2>&1
	done

	return 0
}

function copier() {
	# copy files
	for ITEM in `find . -name "* *"`; do
		cp -R $ITEM $FILEPATHDST
	done
	
	echo "--done--"
	return 0
}

while [ true ]; do
	setpaths
	if [ "$?" -ne "0" ]; then
		break
		exit 1
	fi
	copier
done
