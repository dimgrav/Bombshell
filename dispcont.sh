#!/bin/bash
# dispcont: A simple script to display directory contents
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


SHOW_HIDDEN=false
RECURSIVE=false
INPATH="${@: -1}" # The last argument
declare FILES

COUNTF=0
COUNTD=0
COUNTSYM=0
COUNTU=0
COUNT=0

function parse_args() {
    for (( i=1; i<=${#BASH_ARGV[@]}; i++ )); 
    do
        if [[ ${BASH_ARGV[$i]} = "--hidden" ]]; then
            SHOW_HIDDEN=true
        elif [[ ${BASH_ARGV[$i]} = "--recursive" ]]; then
            RECURSIVE=true
        fi
    done;
}

function inpath() {
	# check input
	if [ "$INPATH" != --* ]; then
		FILEPATH=$INPATH
	else
		read -p "directory path (q to quit): " FILEPATH
	fi

	# cd $FILEPATH > /dev/null 2>&1
    INDIRECTORY="$( cd $FILEPATH > /dev/null 2>&1 && pwd )"

	while [ "$?" -ne "0" ]; do
		if [[ "$FILEPATH" = "q" || "$FILEPATH" = "Q" ]]; then
			echo "--stopped--"
			return 1
		else
			read -p "re-enter path (q to quit): " FILEPATH
		fi
		# cd $FILEPATH > /dev/null 2>&1
        INDIRECTORY="$( cd $FILEPATH > /dev/null 2>&1 && pwd )"
	done

	return 0
}

function counter() {
    local DIRECTORY=${1-$INDIRECTORY}
	# check for hidden option
	if [ "$SHOW_HIDDEN" == true ]; then
		FILES=$(ls -1a ${DIRECTORY})
	else
		FILES=$(ls -1 ${DIRECTORY})
	fi
	# index input path
	for FILE in $FILES
	do
        local FILE_DIRECTORY="${DIRECTORY}/${FILE}"
        echo "${FILE_DIRECTORY}"
		if [ -d "${FILE_DIRECTORY}" ]; then
			if [ "${FILE}" != "." ]  && [ "${FILE}" != ".." ]; then
                ((COUNTD++))
            fi
		elif [ -f "${FILE_DIRECTORY}" ]; then
			((COUNTF++))
		elif [ -L "${FILE_DIRECTORY}" ]; then
			((COUNTSYM++))
		else
			((COUNTU++))
		fi
		((COUNT++))
	done

	return 0
}

function display() {
	# show contents
	echo "------------------------"
	echo "CONTENTS"
	echo "------------------------"
	echo "total items: ${COUNT}"
	echo "directories: ${COUNTD}"
	echo "      files: ${COUNTF}"
	echo "   symlinks: ${COUNTSYM}"
	echo "unspecified: ${COUNTU}"
	echo "------------------------"

	return 0
}


parse_args
inpath
if [ "$?" -ne "0" ]; then
	break
	exit 1
fi
counter
display
