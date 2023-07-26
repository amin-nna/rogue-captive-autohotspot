# A rogue captive portal for Raspberry Pi

This is a simple website and set of configuration files that turns a Raspberry Pi Zero W (or other Pi with WiFi) into a rogue access point. 

Installation after a fresh install of Raspbian Buster Lite:
```
sudo apt update && sudo apt upgrade
sudo apt install git 
git clone https://github.com/amin-nna/rogue-captive-autohotspot
cd rogue-captive-autohotspot
chmod +x install.sh
sudo ./install.sh
sudo reboot

```
During installation, macchanger will ask whether or not MAC addresses should be changed automatically - choose "No". The startup script in rc.local will perform this task more reliably.

