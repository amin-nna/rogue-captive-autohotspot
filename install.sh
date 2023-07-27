#!/bin/sh -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root." 1>&2
   exit 1
fi

echo "Installing dependencies..."
apt update
apt -y install macchanger hostapd dnsmasq apache2 php

echo "Configuring components..."
cp -f hostapd.conf /etc/hostapd/
cp -f dnsmasq.conf /etc/

# Update the defaults file
echo "Updating /etc/default/hostapd"
sed -i 's/#DAEMON_CONF=""/DAEMON_CONF="\/etc\/hostapd\/hostapd.conf"/' /etc/default/hostapd


# Step 5: Disable wifi network in dhcpcd
#echo "Step 5: Disabling wifi network in dhcpcd"
#echo "nohook wpa_supplicant" >> /etc/dhcpcd.conf

# Step 6: Create the autohotspot service file
echo "Step 6: Creating autohotspot service file"
cat > /etc/systemd/system/autohotspot.service <<EOL
[Unit]
Description=Automatically generates an internet Hotspot when a valid SSID is not in range
After=multi-user.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart= autohotspot.sh

[Install]
WantedBy=multi-user.target
EOL

# Step 7: Make the autohotspot script executable
echo "Step 7: Making the autohotspot script executable"
chmod +x autohotspot.sh

# Step 8: Enable the autohotspot service
echo "Step 8: Enabling the autohotspot service"
systemctl enable autohotspot.service

cp -rf html /var/www/
chown -R www-data:www-data /var/www/html
chown root:www-data /var/www/html/.htaccess
cp -f rc.local /etc/
cp -f override.conf /etc/apache2/conf-available/
a2enconf override
a2enmod rewrite

echo "Installation completed successfully!"
echo "Please reboot your Raspberry Pi to start using the hotspot."

exit 0

