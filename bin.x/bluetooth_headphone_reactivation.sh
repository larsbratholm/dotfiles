#!/bin/sh

device_mac="2C:41:A1:C9:21:A9"

systemctl restart bluetooth
sleep 5
pacmd set-card-profile `pacmd list-cards | grep bluez_card -B1 | grep index | awk '{print $2}'` off
sleep 2 
echo "disconnect $device_mac\n quit"|bluetoothctl
sleep 5
echo "connect $device_mac\n quit"|bluetoothctl
sleep 5
pacmd set-card-profile `pacmd list-cards | grep bluez_card -B1 | grep index | awk '{print $2}'` a2dp_sink
pactl load-module module-bluetooth-discover
