# shell-scripts

Collection of Shell scripts for BASH

*	dispindex:	a simple script to display directory contents

## Running scripts from any location via terminal

In order to run a Shell script from anywhere on your system, you have 
to add the script's directory path to the $PATH variable of your OS.

To do so:

1.	Create a directory to store custom shell scripts (e.g. ~/scripts)
2.	Open ~/.bashrc with a text editor, e.g. NANO (nano ~/.bashrc)
3.	Add the following line at the end of .bashrc:
	.	export PATH=~/scripts:$PATH
4.	Restart your user session (reboot or log out and in again)

Make sure you have made the scripts executable (run chmod u+x <filename>)!

