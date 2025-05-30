#!/bin/bash

echo "📱 ADB over Wi-Fi Automation Tool"
echo "🔧 Developed by R2BRAHUL (Cyber7F)"

if ! command -v adb &> /dev/null
then
    echo "❌ ADB not found. Installing android-tools..."
    pkg install android-tools -y
fi

echo "🔍 Checking for connected device via USB..."
adb devices
sleep 2

echo "🔄 Switching ADB to TCP/IP mode..."
adb tcpip 5555
sleep 2

DEVICE_IP=$(adb shell ip -f inet addr show wlan0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1)

if [ -z "$DEVICE_IP" ]; then
    echo "❌ IP not found. Make sure you're on Wi-Fi and ADB is authorized."
    exit 1
fi

echo "✅ Device IP: $DEVICE_IP"

adb connect "$DEVICE_IP:5555"

echo "📋 Connected Devices:"
adb devices
