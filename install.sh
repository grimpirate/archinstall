#!/bin/sh

STEP=$(dialog --title "ARCH LINUX" --menu "Select procedure" 8 45 0 1 "Network setup" 2>&1 >/dev/tty)

case $STEP in
	1)
		curl -fsSL https://github.com/grimpirate/archinstall/raw/refs/heads/main/network.sh | sh
	;;
	*)
		dialog --title "EXIT" --msgbox "Install cancelled" 6 45
	;;
esac

exit 0