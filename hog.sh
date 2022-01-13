#!/bin/bash



# See what files and directories are hogging the least and most space.
#
# Syntax:
# hog
#
# Create a soft link with:
# cd /usr/local/bin; sudo ln -sf /code_directory/termtools/hog.sh hog


du -a -b --max-depth=1 | sort -n
