#!/bin/bash

# Use wpa_cli to reconfigure wpa_supplicant and try to connect to known networks
wpa_cli -i wlan0 reconfigure

# Sleep for 15 seconds to give time for connection
sleep 15

# get the currently connected WiFi network
connected_ssid=$(iwgetid -r)

# check if we're connected to a WiFi network
if [[ -n $connected_ssid ]]; then
    echo "Connected to network $connected_ssid"
    exit 0
else
    # if we're not connected to a known network, create a hotspot
    echo "Creating hotspot..."
    sh hotspot.sh
fi

exit 0
