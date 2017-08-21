# Bombshell
## Collection of Shell scripts for BASH

This project is intended to become a solid library of useful Shell scripts for 
everyday computing. A small, yet powerful toolbox, which will help automate and 
quicken repetitive tasks that Linux users perform daily.

### Script list

*	dispindex:	a simple script to display grouped totals of directory contents

## Running scripts from any location via terminal

In order to run a Shell script from anywhere on your system, you have to 
add the script's directory path to the $PATH environment variable of your OS.

To do so:

1.	Create a directory to store custom shell scripts (e.g. `$ mkdir ~/scripts`)
2.	Open ~/.profile with a text editor, e.g. NANO (`$ nano ~/.profile`)
3.	Add the following lines at the end of .profile:
```
PATH=~/scripts:$PATH
export PATH
```
4.	Restart your user session (reboot or log out and in again)

Make sure you have set the script as **executable** for your user account!
(`$ chmod u+x <script>`)

To verify that you have x-ecute permissions on the script, run `$ ls -l <script>`, 
the permissions format should look like the bold characters in the line below:

**-rwx**`rw-r-- 1 username users 2048 Jul 6 12:56 script.sh`

*Understanding permissions is ***vital*** in scripting, make sure you don't give x 
permission to the wrong user or usergroup on your system!*
