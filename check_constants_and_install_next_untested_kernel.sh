#!/bin/sh

die() {
    if [ $# -lt 1 ]; then 
        echo "ERROR: unexpected error, exiting."
    else
        echo "ERROR: $1, exiting."
    fi
    exit 1
}

CURRENT_KERN=$(uname -r)

if [ ! -f $CURRENT_KERN.res ]; then 
    echo "First, generating result for current $CURRENT_KERN kernel version"
    ./check_constants.sh || die "checking constants"
fi

# grab available kernels
if [ ! -f avail_kernels.txt ]; then
    echo "avail_kernels.txt not present, generate it"
    ./list_avail_kernels.sh
fi

# check for the next kernel version for wich we did not have any constant result yet
TO_INSTALL=""
for K in $(cat avail_kernels.txt); do
    VERSION=${K#linux-image-}
    if [ ! -f $VERSION.res ]; then 
        TO_INSTALL=$K
        break
    fi
done

if [ -z "$TO_INSTALL" ]; then # all available kernel version were tested
    echo "All available kernel were checked"
    echo "You should now consider installing back your wanted kernel. Older ones have been backuped to /boot/backup"
    echo "(move back your wanted kernel to /boot and run grub-update)"
    exit 0
fi

# install next kernel
echo "Results for $TO_INSTALL are missing. I will installing it for you:"
sudo apt-get install "$TO_INSTALL" || die "apt-get install $TO_INSTALL"

# update grub to boot on it
sudo mkdir -p /boot/backup/ || die "mkdir -p /boot/backup/"
sudo mv /boot/*$CURRENT_KERN* /boot/backup/|| die "mv /boot/*$CURRENT_KERN* /boot/backup/"
sudo update-grub || die "update-grub"
echo "You can now reboot and relaunch this script!"
