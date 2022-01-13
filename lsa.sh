#!/bin/bash



# Shortcut to 'lsattr -al'.
#
# Syntax:
#
# List everything in the current directory:
# lsa
#
# List only specified files and directories:
# lsa [files and directories]
#
# List directories recursively:
# lsa *
#
# Create a soft link with:
# cd /usr/local/bin; sudo ln -sf /code_directory/termtools/lsa.sh lsa


lsattr -al "$@"
