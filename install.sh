#!/bin/bash

clear
echo "📦 Installing ADB Wi-Fi Tool and Dependencies..."

# Update Termux
pkg update -y && pkg upgrade -y

# Install core dependencies
pkg install -y android-tools git figlet ruby

# Install lolcat via Ruby
gem install lolcat

# Copy main script to bin for global access
cp adbwifi.sh /data/data/com.termux/files/usr/bin/adbwifi
chmod +x /data/data/com.termux/files/usr/bin/adbwifi

# Done!
echo ""
figlet "Cyber7F" | lolcat
echo -e "\xF0\x9F\x94\xA7 ADB over Wi-Fi Framework by R2BRAHUL" | lolcat
echo -e "\xE2\x9C\x85 Installation complete!"
echo -e "\xF0\x9F\x9A\x80 Run the tool using: \033[1;32madbwifi\033[0m" | lolcat
