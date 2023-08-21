#!/bin/bash
# Start wpa_supplicant
wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf
# Use wpa_cli to reconfigure wpa_supplicant and try to connect to known networks
wpa_cli -i wlan0 reconfigure
# Sleep for 15 seconds to give time for connection
sleep 15
# Get the currently connected WiFi network
connected_ssid=$(iwgetid -r)
# Check if we're connected to a WiFi network
if [[ -n $connected_ssid ]]; then
    echo "Connected to network $connected_ssid"
    exit 0
else
    # If we're not connected to a known network, create a hotspot
    echo "Creating hotspot..."
    sh hotspot.sh
fi
exit 0

