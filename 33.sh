#!/bin/bash



# Syncs specified file or all files in the present directory to the same directory on a specified tertiary backup drive using rsync.
# See '11.sh' and '22.sh' for primary and secondary drives.
#
# Syntax:
# 33
#
# Set the directory prefix using the 'tertiary' variable.
# i.e.
# tertiary='/media/user/PERSIST3'
#
# Create a soft link with:
# cd /usr/local/bin; sudo ln -sf /code_directory/termtools/33.sh 33


tertiary='/media/user/PERSIST3'
dest=$primary$(pwd)

if [[ -z "$1" ]]; then
   echo "No argument given.  Sync present working directory?  ( Y / N )"
   read q
   case $q in
   [yY]) sudo rsync -vAXcHad --progress --delete --exclude=.Trash-1000 --exclude=lost+found "$(pwd)" "$dest"/ ;;
   [nN]) echo "Exiting..."; exit 1 ;;
   *) echo "Ambiguous input.  Exiting..."; exit 1 ;;
   esac;
fi

filename="$1"
case "${filename: -1}" in */*) filename=${filename::-1}; ;; esac
sudo rsync -vAXcHad --progress --delete --exclude=.Trash-1000 --exclude=lost+found "$filename" "$dest"/
