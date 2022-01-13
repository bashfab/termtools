#!/bin/bash



# Copies a specified file to the same directory on a specified primary backup drive.
# See '2.sh' and '3.sh' for secondary and tertiary drives.
# It does not support wildcard; use '1all.sh' instead.
# It is set with -rpv (recursive, preserve permissions, and verbose) arguments. 
#
# Syntax:
# 1 'filename'
#
# Set the directory prefix using the 'primary' variable.
# i.e.
# primary='/media/user/PRIMARY'
#
# Create a soft link with:
# cd /usr/local/bin; sudo ln -sf /code_directory/termtools/1.sh 1


primary='/media/user/PRIMARY'
if [[ -z "$1" ]]; then echo "No argument given."; exit 1; fi
cp -rpv "$1" "$primary$(pwd)"
