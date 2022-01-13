#!/bin/bash



# Finds changes to the status and content of files in major directories within specified minutes.
#
# Syntax:
# changes [number of minutes]
#
# Set the data directory using the 'data' variable.
# i.e.
# data="/data"
#
# Create a soft link with:
# cd /usr/local/bin; sudo ln -sf /code_directory/termtools/changes.sh changes


if [[ -z "$1" ]]; then
   echo "Missing argument; specify minutes."
   exit 1
fi

data="/data"
min="$1"

echo "Finding any changes to important directories made in the last "$min" minutes."
echo
echo "Status changes to files in ~/"
echo "-----------------------------"
find $HOME -cmin -$min
echo
echo "Content changes to files in ~/"
echo "------------------------------"
find $HOME -mmin -$min
echo
echo
echo
echo "Status changes to files in /etc"
echo "-------------------------------"
find /etc -cmin -$min
echo
echo "Content changes to files in /etc"
echo "-------------------------------"
find /etc -mmin -$min
echo
echo
echo
echo "Status changes to files in /usr"
echo "-------------------------------"
find /usr -cmin -$min
echo
echo "Content changes to files in /usr"
echo "--------------------------------"
find /usr -mmin -$min
echo
echo
echo
echo "Status changes to files in /boot"
echo "--------------------------------"
find /boot -cmin -$min
echo
echo "Content changes to files in /boot"
echo "--------------------------------"
find /boot -mmin -$min
echo
echo
echo
echo "Status changes to files in /data"
echo "--------------------------------"
find $data -cmin -$min
echo
echo "Content changes to files in /data"
echo "---------------------------------"
find $data -mmin -$min
