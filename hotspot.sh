#!/bin/bash

# use the settings you provided for the hotspot
cp -f hostapd.conf /etc/hostapd/
cp -f dnsmasq.conf /etc/
service hostapd start
service dnsmasq start

echo "Hotspot started"
exit 0
