#!/bin/sh -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root." 1>&2
   exit 1
fi

echo "Installing dependencies..."
sudo apt -y update
sudo apt -y install macchanger hostapd dnsmasq lighttpd

echo "Configuring components..."
cp -f hostapd.conf /etc/hostapd/
cp -f dnsmasq.conf /etc/

# Update the defaults file
echo "Updating /etc/default/hostapd"
sed -i 's/#DAEMON_CONF=""/DAEMON_CONF="\/etc\/hostapd\/hostapd.conf"/' /etc/default/hostapd

# Step 6: Create the autohotspot service file
echo "Step 6: Creating autohotspot service file"
cat > /etc/systemd/system/autohotspot.service <<EOL
[Unit]
Description=Automatically generates an internet Hotspot when a valid SSID is not in range
After=multi-user.target

[Service]
ExecStart=/bin/bash autohotspot.sh
Type=oneshot

[Install]
WantedBy=multi-user.target
EOL

# Step 8: Enable the autohotspot service
echo "Step 8: Enabling the autohotspot service"
sudosystemctl enable autohotspot.service
sudo systemctl enable hostapd
sudo systemctl enable dnsmasq
sudo systemctl enable lighttpd

echo "Installation completed successfully!"
echo "Please reboot your Raspberry Pi to start using the hotspot."

exit 0


