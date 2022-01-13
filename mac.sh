#!/bin/bash



# Generates a random MAC address using /dev/urandom.
#
# Syntax:
# mac
#
# Create a soft link with:
# cd /usr/local/bin; sudo ln -sf /code_directory/termtools/mac.sh mac


echo "Generating a random MAC address..."
mac=$(printf '%02x' $((0x$(od /dev/urandom -N1 -t x1 -An | cut -c 2-) & 0xFE | 0x02)); od /dev/urandom -N5 -t x1 -An | sed 's/ /:/g')
mac=$(echo $mac | tr '[:lower:]' '[:upper:]')
echo "Here you go:"
echo $mac
