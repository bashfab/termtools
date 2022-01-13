#!/bin/bash



# Copies a specified file to the same directory on a specified secondary backup drive.
# See '1.sh' and '3.sh' for primary and tertiary drives.
# It does not support wildcard; use '2all.sh' instead.
# It is set with -rpv (recursive, preserve permissions, and verbose) arguments. 
#
# Syntax:
# 2 'filename'
#
# Set the directory prefix using the 'secondary' variable.
# i.e.
# secondary='/media/user/SECONDARY'
#
# Create a soft link with:
# cd /usr/local/bin; sudo ln -sf /code_directory/termtools/fileop/2.sh 2


secondary='/media/user/SECONDARY'
if [[ -z "$1" ]]; then echo "No argument given."; exit 1; fi
cp -rpv "$1" "$secondary$(pwd)"
