#!/bin/sh

DEVICE=$(dialog --title "DEVICE" --menu "Select wireless device" 8 45 0 $(iwctl device list | sed -E '1,4s/.*//g' | awk '{printf("%s %s", $2, $3)}' | sed -E 's/^\s*//') 2>&1 >/dev/tty)

if [[ -z "$DEVICE" ]]; then
	dialog --title "EXIT" --msgbox "No device selected" 6 45
	exit 1
fi

iwctl device $DEVICE set-property Powered on
iwctl station $DEVICE scan

SSID=$(dialog --title "SSID" --menu "Select wireless network" 8 45 0 $(iwctl station $DEVICE get-networks | sed -E '1,4s/.*//g' | sed -E '5s/^.{21}//' | sed -E '6,$s/^.{6}//' | awk '{printf("%s %s ", $1, $2)}') 2>&1 >/dev/tty)

if [[ -z "$SSID" ]]; then
	dialog --title "EXIT" --msgbox "No network selected" 6 45
	exit 1
fi

PASSWORD=$(dialog --title "AUTHENTICATE" --passwordbox "Password" 6 45 2>&1 >/dev/tty)

iwctl --passphrase=\"$PASSWORD\" station $DEVICE connect $SSID

ping -c 3 ping.archlinux.org >/dev/null 2>&1

if [ $? -eq 0 ]; then
	dialog --title "NETWORK" --msgbox "Connection success" 6 45
else
	dialog --title "NETWORK" --msgbox "Connection failure" 6 45
fi

exit 0