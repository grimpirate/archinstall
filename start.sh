#!/bin/sh

source ./install_arch.sh

dialog --title "Arch Linux Install" --yes-label "Proceed" --no-label "Cancel" --yesno "\nhttps://github.com/grimpirate/archinstall" 6 45

RESPONSE=$?

case $RESPONSE in
	0)
		arch_install
		;;
	*)
		echo "Install cancelled." >&2
		;;
esac.
