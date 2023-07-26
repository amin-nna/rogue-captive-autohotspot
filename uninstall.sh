#!/bin/sh -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root." 1>&2
   exit 1
fi

echo "Uninstalling AutoHotspot..."

# Step 1: Disable the autohotspot service
echo "Disabling autohotspot service..."
systemctl disable autohotspot.service

# Step 2: Remove the autohotspot service file
echo "Removing autohotspot service file..."
rm -f /etc/systemd/system/autohotspot.service

# Step 3: Remove the autohotspot script
echo "Removing autohotspot script..."
rm -f /rogue-captive-autohotspot/autohotspot.sh

# Step 4: Remove the custom dnsmasq and hostapd configurations
echo "Removing custom dnsmasq and hostapd configurations..."
rm -f /etc/dnsmasq.conf
rm -f /etc/hostapd/hostapd.conf

# Step 5: Restore the original dhcpcd configuration
echo "Restoring original dhcpcd configuration..."
sed -i '/nohook wpa_supplicant/d' /etc/dhcpcd.conf

# Step 6: Remove installed packages
echo "Removing installed packages..."
apt -y purge macchanger hostapd dnsmasq apache2 php
apt -y autoremove

# Step 7: Remove copied files
echo "Removing copied files..."
rm -rf /var/www/html
rm -f /etc/rc.local
rm -f /etc/apache2/conf-available/override.conf

echo "AutoHotspot uninstalled successfully!"
exit 0
