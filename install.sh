#!/bin/sh -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root." 1>&2
   exit 1
fi

echo "Installing dependencies..."
apt update
apt -y install macchanger hostapd dnsmasq

echo "Installing Node.js..."
wget https://nodejs.org/dist/latest-v10.x/node-v10.24.1-linux-armv6l.tar.xz
tar -xJf node-v10.24.1-linux-armv6l.tar.xz
cd node-v10.24.1-linux-armv6l/
sudo cp -R * /usr/local/
cd ..

echo "Configuring components..."
cp -f hostapd.conf /etc/hostapd/
cp -f dnsmasq.conf /etc/

# Update the defaults file
echo "Updating /etc/default/hostapd"
sed -i 's/#DAEMON_CONF=""/DAEMON_CONF="\/etc\/hostapd\/hostapd.conf"/' /etc/default/hostapd

# Step 5: Disable wifi network in dhcpcd
#echo "Step 5: Disabling wifi network in dhcpcd"
#echo "nohook wpa_supplicant" >> /etc/dhcpcd.conf

# Step 6: Creating autohotspot service file
cat > /etc/systemd/system/autohotspot.service <<EOL
[Unit]
Description=Automatically generates an internet Hotspot when a valid SSID is not in range
After=multi-user.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/node /var/www/html/server.js

[Install]
WantedBy=multi-user.target
EOL

# Step 7: Making the server.js script
if [ ! -d "/var/www/html/" ]; then
  mkdir -p /var/www/html/
fi
cat > /var/www/html/server.js <<EOL
var http = require('http');
var fs = require('fs');

http.createServer(function (req, res) {
  fs.readFile('/var/www/html/index.html', function(err, data) {
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.write(data);
    res.end();
  });
}).listen(8080);
EOL


echo "Making the server script executable"
chmod +x /var/www/html/server.js

# Step 8: Enable the autohotspot service
echo "Step 8: Enabling the autohotspot service"
systemctl enable autohotspot.service

echo "Installation completed successfully!"
echo "Please reboot your Raspberry Pi to start using the hotspot."

exit 0

