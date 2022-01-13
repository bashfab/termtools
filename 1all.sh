#!/bin/bash



# Copies all files in the present directory to the same directory on a specified primary backup drive.
# See '2all.sh' and '3all.sh' for secondary and tertiary drives.
# It is set with -rpv (recursive, preserve permissions, and verbose) arguments.
#
# Syntax:
# 1all
#
# Set the directory prefix using the 'primary' variable.
# i.e.
# primary='/media/user/PRIMARY'
#
# Create a soft link with:
# cd /usr/local/bin; sudo ln -sf /code_directory/termtools/1all.sh 1all


primary='/media/user/PRIMARY'
cp -rpv * "$primary$(pwd)"/
