#!/bin/bash

clear

# ░█▀▀░█▀▀░█▄█░█▀█░█▀█░█░█░█▀▀
# ░▀▀█░█▀▀░█░█░█▀▀░█░█░░█░░█▀▀
# ░▀▀▀░▀▀▀░▀░▀░▀░░░▀░▀░░▀░░▀▀▀

figlet "Cyber7F" | lolcat
echo -e "\xF0\x9F\x94\xA7 ADB over Wi-Fi Automation Framework" | lolcat
echo -e "\xF0\x9F\x94\xB9 Developed by R2BRAHUL | Powered by Cyber7F" | lolcat
echo "-------------------------------------------------" | lolcat
sleep 1

# 🔧 Install adb if not found
if ! command -v adb &> /dev/null; then
    echo -e "\xE2\x9D\x8C ADB not found. Installing..." | lolcat
    pkg install android-tools -y
fi

# 📡 Connect over Wi-Fi
connect_wifi() {
    echo -e "\xF0\x9F\x94\x8D Looking for connected Android device..." | lolcat
    adb devices
    sleep 1

    DEVICE_STATUS=$(adb devices | sed -n '2p' | awk '{print $2}')
    if [ "$DEVICE_STATUS" != "device" ]; then
        echo -e "\xE2\x9D\x8C No authorized device found!" | lolcat
        echo -e "\xF0\x9F\x93\x8C Make sure:" | lolcat
        echo -e "   \xF0\x9F\x94\xB8 USB connected, ADB debugging ON" | lolcat
        echo -e "   \xF0\x9F\x94\xB8 Authorization accepted on phone" | lolcat
        return
    fi

    echo -e "\xE2\x9C\x85 Device Authorized!" | lolcat
    adb tcpip 5555
    sleep 1
    DEVICE_IP=$(adb shell ip -f inet addr show wlan0 | grep -oP '(?<=inet )\d+(\.\d+){3}' | head -n 1)

    if [ -z "$DEVICE_IP" ]; then
        echo -e "\xE2\x9D\x8C IP not found. Make sure Wi-Fi is active." | lolcat
        return
    fi

    echo -e "\xF0\x9F\x93\xB6 Connecting to: $DEVICE_IP:5555" | lolcat
    adb connect "$DEVICE_IP:5555"
    adb devices | lolcat
}

# 💻 ADB Shell
adb_shell() {
    echo -e "\xF0\x9F\xA7\xA0 Entering ADB Shell..." | lolcat
    adb shell
}

# 📥 Pull File
pull_file() {
    echo -e "\xF0\x9F\x93\xA5 Enter path to file on device: " | lolcat
    read device_path
    echo -e "\xF0\x9F\x93\x81 Enter local save path: " | lolcat
    read local_path
    adb pull "$device_path" "$local_path"
}

# 📤 Push File
push_file() {
    echo -e "\xF0\x9F\x93\xA4 Enter local file path: " | lolcat
    read local_path
    echo -e "\xF0\x9F\x93\x81 Enter target path on device: " | lolcat
    read device_path
    adb push "$local_path" "$device_path"
}

# ℹ️ Device Info
device_info() {
    echo -e "\xF0\x9F\x93\xB1 Getting Device Info..." | lolcat
    MODEL=$(adb shell getprop ro.product.model)
    BRAND=$(adb shell getprop ro.product.brand)
    VERSION=$(adb shell getprop ro.build.version.release)
    BATTERY=$(adb shell dumpsys battery | grep level | awk '{print $2}')
    STORAGE=$(adb shell df /data | tail -1 | awk '{print $4}')

    echo -e "\xF0\x9F\x93\x8C Device: $BRAND $MODEL" | lolcat
    echo -e "\xF0\x9F\x93\xB1 Android Version: $VERSION" | lolcat
    echo -e "\xF0\x9F\x94\x8B Battery Level: $BATTERY%" | lolcat
    echo -e "\xF0\x9F\x92\xBE Free Storage: $STORAGE" | lolcat
}

# 🧭 Main Menu
main_menu() {
    while true; do
        echo ""
        echo -e "\xF0\x9F\x93\x98 Main Menu" | lolcat
        echo -e "1️⃣  Connect over Wi-Fi"
        echo -e "2️⃣  ADB Shell Access"
        echo -e "3️⃣  Pull File from Device"
        echo -e "4️⃣  Push File to Device"
        echo -e "5️⃣  Exit"
        echo -e "6️⃣  Device Info"
        echo -n -e "\xE2\x9E\xA1️  Choose an option: "
        read choice

        case $choice in
            1) connect_wifi ;;
            2) adb_shell ;;
            3) pull_file ;;
            4) push_file ;;
            5) echo -e "\xF0\x9F\x91\x8B Exiting... Stay secure!" | lolcat; exit 0 ;;
            6) device_info ;;
            *) echo -e "\xE2\x9D\x8C Invalid choice!" | lolcat ;;
        esac
    done
}

# 🚀 Launch Tool
main_menu
