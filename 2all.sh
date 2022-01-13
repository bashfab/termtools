#!/bin/bash



# Copies all files in the present directory to the same directory on a specified secondary backup drive.
# See '1all.sh' and '3all.sh' for primary and tertiary drives.
# It is set with -rpv (recursive, preserve permissions, and verbose) arguments.
#
# Syntax:
# 2all
#
# Set the directory prefix using the 'secondary' variable.
# i.e.
# secondary='/media/user/SECONDARY'
#
# Create a soft link with:
# cd /usr/local/bin; sudo ln -sf /code_directory/termtools/2all.sh 2all


secondary='/media/user/SECONDARY'
cp -rpv * "$secondary$(pwd)"/
