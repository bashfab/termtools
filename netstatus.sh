#!/bin/bash
#!/usr/bin/python3.5


# netstatus.sh reports:
# - wired and wireless device names, UUIDs, and local IP addresses
# - devices connected to the local network
# - available WiFi connections
# and relies on NetworkManager and nmcli.
#
# Syntax:
# netstatus
#
# You must specify the names of the wired and/or wireless connections to use below in the following variables:
# - wired_connection
# - wireless_connection
# Use 'nmcli connection show' to get the names or open Network Manager.
#
# Note if your connection doesn't appear in /etc/NetworkManager/system-connections you will receive an error.
#
# Create a soft link with:
# cd /usr/local/bin; sudo ln -sf /code_directory/termtools/netstatus.sh netstatus


function netstatus {

# initialize variables
mkdir /dev/shm/temp 2> /dev/null
lastconuptime="(hasn't connected since this session began)"


# specify names of wired and wireless connections to use
wired_connection="Wired connection"
wireless_connection="Wireless connection"
selnetcon=$wired_connection


# find device names
wired_device=$(nmcli dev status | grep "ethernet" | head -n1 | cut -d " " -f1)
wireless_device=$(nmcli dev status | grep "wifi" | head -n1 | cut -d " " -f1)


# find uuids
wired_uuid_precursor1=$(nmcli c | grep "ethernet")
wired_status=$(nmcli connection show | grep -o "$wired_device")
if [[ "$wired_status" == "$wired_device" ]]; then wired_uuid_precursor2=$(expr "$wired_uuid_precursor1" : "\(.*\)$wired_device"); else wired_uuid_precursor2=$(expr "$wired_uuid_precursor1" : "\(.*\)--"); fi
wired_uuid=$(echo $wired_uuid_precursor2 | sed 's/\(.*\) .*/\1/' | awk -F" " '$0=$NF')

wireless_uuid_precursor1=$(nmcli c | grep "wireless")
wireless_status=$(nmcli connection show | grep -o "$wireless_device")
if [[ "$wireless_status" == "$wireless_device" ]]; then wireless_uuid_precursor2=$(expr "$wireless_uuid_precursor1" : "\(.*\)$wireless_device"); else wireless_uuid_precursor2=$(expr "$wireless_uuid_precursor1" : "\(.*\)--"); fi
wireless_uuid=$(echo $wireless_uuid_precursor2 | sed 's/\(.*\) .*/\1/' | awk -F" " '$0=$NF')


# wired and wireless device local IPs
wired_device_ip=$(ifconfig $wired_device | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | sed 's/^.\{10\}//g')
wireless_device_ip=$(ifconfig $wireless_device | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | sed 's/^.\{10\}//g')
if [ ! -n "$wired_device_ip" ]; then wired_device_ip="[not available]"; fi
if [ ! -n "$wireless_device_ip" ]; then wireless_device_ip="[not available]"; fi


# check network status
wiredup=$(nmcli connection show "$wired_connection" | grep -o "activated")
wirelessup=$(nmcli connection show "$wireless_connection" | grep -o "activated")
if [[ "$wiredup" == "activated" ]] && [[ "$selnetcon" == "$wired_connection" ]]; then selnetcondown=0; lastconuptime=$(date); fi
if [[ "$wiredup" != "activated" ]] && [[ "$selnetcon" == "$wired_connection" ]]; then selnetcondown=1; fi
if [[ "$wirelessup" == "activated" ]] && [[ "$selnetcon" == "$wireless_connection" ]]; then selnetcondown=0; lastconuptime=$(date); fi
if [[ "$wirelessup" != "activated" ]] && [[ "$selnetcon" == "$wireless_connection" ]]; then selnetcondown=1; fi


# find current, cloned, and permanent MAC address values
wired_cloned_precursor=$(sudo cat /etc/NetworkManager/system-connections/"$wired_connection")
is_wired_cloned=$(echo $wired_cloned_precursor | grep -o "cloned")
if [[ "$is_wired_cloned" == "cloned" ]]; then wired_cloned=$(echo $wired_cloned_precursor | sed 's/.*cloned-mac-address=//' | sed -r 's/(.* duplex).*/\1/' | rev | cut -c8- | rev); wired_current=$wired_cloned; else wired_cloned="[no cloned MAC specified]"; wired_current=$(cat /sys/class/net/"$wired_device"/address | tr '[:lower:]' '[:upper:]'); fi
wireless_cloned_precursor=$(sudo cat /etc/NetworkManager/system-connections/"$wireless_connection")
is_wireless_cloned=$(echo $wireless_cloned_precursor | grep -o "cloned")
if [[ "$is_wireless_cloned" == "cloned" ]]; then wireless_cloned=$(echo $wireless_cloned_precursor | sed 's/.*cloned-mac-address=//' | sed -r 's/(.* mac-address-blacklist=).*/\1/' | rev | cut -c24- | rev); wireless_current=$wireless_cloned; else wireless_cloned="[no cloned MAC specified]"; wireless_current=$(cat /sys/class/net/"$wireless_device"/address | tr '[:lower:]' '[:upper:]'); fi
wired_permanent="$(ethtool -P $wired_device | awk -F" " '$0=$NF' | tr '[:lower:]' '[:upper:]')"
wireless_permanent="$(ethtool -P $wireless_device | awk -F" " '$0=$NF' | tr '[:lower:]' '[:upper:]')"
line1color=""; line2color=""; line3color=""; line4color=""; line5color=""; line6color=""
if [[ "$wired_current" != "$wired_cloned" ]]; then line1color="0;31m"; line2color="0;31m"; line3color="0;33m"; else line1color="0;32m"; line2color="0;32m"; line3color="0;33m"; fi
if [[ "$wired_current" == "$wired_permanent" ]]; then line1color="0;31m"; line3color="0;31m"; fi
if [[ "$wired_cloned" == "$wired_permanent" ]]; then line2color="0;31m"; line3color="0;31m"; fi
if [[ "$wireless_current" != "$wireless_cloned" ]]; then line4color="0;31m"; line5color="0;31m"; line6color="0;33m"; else line4color="0;32m"; line5color="0;32m"; line6color="0;33m"; fi
if [[ "$wireless_current" == "$wireless_permanent" ]]; then line4color="0;31m"; line6color="0;31m"; fi
if [[ "$wireless_cloned" == "$wireless_permanent" ]]; then line5color="0;31m"; line6color="0;31m"; fi


echo
echo
echo "DEVICE DESIGNATIONS"
echo "==================="
echo "The wired device appears to be: "$wired_device
echo "The wireless device appears to be: "$wireless_device
echo
echo
echo "DEVICE UUIDS"
echo "============"
echo "The above wired device is assigned to UUID: "$wired_uuid
echo "The above wireless device is assigned to UUID: "$wireless_uuid
echo
echo
echo "LOCAL IP ADDRESSES"
echo "=================="
echo "The above wired adapter: "$wired_device_ip
echo "The above wireless adapter: "$wireless_device_ip
echo
echo
echo "MAC ADDRESSES as of $(date)"
echo "(default = red, permanent = yellow, non-default = green)"
echo "============="
echo -n "Wired (current): "; echo -e "\033[$line1color$wired_current\033[0m"
echo -n "Wired (cloned): "; echo -e "\033[$line2color$wired_cloned\033[0m"
echo -n "Wired (permanent): "; echo -e "\033[$line3color$wired_permanent\033[0m"
echo -n "Wireless (current): "; echo -e "\033[$line4color$wireless_current\033[0m"
echo -n "Wireless (cloned): "; echo -e "\033[$line5color$wireless_cloned\033[0m"
echo -n "Wireless (permanent): "; echo -e "\033[$line6color$wireless_permanent\033[0m"
echo
echo
echo "NETWORK STATUS as of $(date)"
echo "=============="
if [[ "$selnetcondown" == "0" ]]; then echo "Selected connection \"$selnetcon\" is activated as of $lastconuptime..."; fi
echo "$run"
if [[ "$selnetcondown" == "1" ]]; then echo "Selected network connection: Offline."; fi
echo
echo "OTHER DEVICES ON THE LOCAL NETWORK as of $(date)"
echo "=================================="
if [[ "$selnetcondown" != "1" ]]; then echo -n "Wired device: "; sudo arp-scan --interface=$wired_device --localnet; echo; echo -n "Wireless device: "; sudo arp-scan --interface=$wireless_device --localnet; fi
echo
echo
echo "AVAILABLE NETWORK MANAGER CONNECTIONS"
echo "====================================="
nmcli connection show
# It would be useful if there is a way to show only connections that are accessible to the network card in its present state (active/inactive).
echo
echo
nmcli device wifi rescan
sleep .5
echo "AVAILABLE WIFI CONNECTIONS"
echo "=========================="
nmcli device wifi list
echo
echo
echo "Press X to exit or ENTER to run again..."
read q
case $q in
  [xX]) exit ;;
  *) netstatus ;;
esac

}


netstatus
