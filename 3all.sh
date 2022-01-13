#!/bin/bash



# Copies all files in the present directory to the same directory on a specified tertiary backup drive.
# See '1all.sh' and '2all.sh' for primary and secondary drives.
# It is set with -rpv (recursive, preserve permissions, and verbose) arguments.
#
# Syntax:
# 3all
#
# Set the directory prefix using the 'tertiary' variable.
# i.e.
# tertiary='/media/user/TERTIARY'
#
# Create a soft link with:
# cd /usr/local/bin; sudo ln -sf /code_directory/termtools/3all.sh 3all


tertiary='/media/user/TERTIARY'
cp -rpv * "$tertiary$(pwd)"/
