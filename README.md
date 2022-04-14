# Scripts to automagically check DataDog Agent constants on all available kernels for a Linux distribution

## How to use it: 

Fisrt, testsuite should be present on the working dir.

Then, just:

- launch check_constants_and_install_next_untested_kernel.sh
- reboot
- loop

check_constant_and_install_next_untested_kernel will:

- check constants (by running the octogone test suite) for the current kernel
- if not yet listed, list all available kernel versions for your distribution
- install the next kernel of the list for which we did not have results yet
- update grub to boot on it (backuping the current kernel to /boot/backup before running update-grub) 


## Limitations:

For now it only works for APT distributions (Debian, Ubuntu).
