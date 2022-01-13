#!/bin/bash



# Copies a specified file to the same directory on a specified tertiary backup drive.
# See '1.sh' and '2.sh' for primary and secondary drives.
# It does not support wildcard; use '3all.sh' instead.
# It is set with -rpv (recursive, preserve permissions, and verbose) arguments. 
#
# Syntax:
# 3 'filename'
#
# Set the directory prefix using the 'tertiary' variable.
# i.e.
# tertiary='/media/user/TERTIARY'
#
# Create a soft link with:
# cd /usr/local/bin; sudo ln -sf /code_directory/termtools/3.sh 3


tertiary='/media/user/TERTIARY'
if [[ -z "$1" ]]; then echo "No argument given."; exit 1; fi
cp -rpv "$1" "$tertiary$(pwd)"
