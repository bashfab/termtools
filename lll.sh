#!/bin/bash



# Lists files with the full date and time down to the nanosecond.
#
# Syntax:
# lll
# lll [file or directory name]
#
# Create a soft link with:
# cd /usr/local/bin; sudo ln -sf /code_directory/termtools/lll.sh lll


if [[ -z "$1" ]]; then ls -al --full-time; else ls -al --full-time "$1"; fi
