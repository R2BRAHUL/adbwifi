#!/bin/bash

echo "📦 Installing ADB Wi-Fi Tool..."

mkdir -p $PREFIX/bin

cp adbwifi.sh $PREFIX/bin/adbwifi
chmod +x $PREFIX/bin/adbwifi

echo "✅ Installation complete! Now you can run the tool using: adbwifi"
