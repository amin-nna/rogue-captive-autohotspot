#!/bin/bash

# define the SSIDs of your known networks here
declare -a ssids=('network1' 'network2')

# get the currently connected WiFi network
connected_ssid=$(iwgetid -r)

# check if we're connected to a WiFi network
if [[ -n $connected_ssid ]]; then
    for i in "${ssids[@]}"; do
        # if we're connected to a known network, exit the script
        if [[ $i == $connected_ssid ]]; then
            echo "Connected to known network $connected_ssid"
            exit 0
        fi
    done
fi

# if we're not connected to a known network, create a hotspot
echo "Creating hotspot..."
sh hotspot.sh

exit 0
