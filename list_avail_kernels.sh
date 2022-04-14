#!/bin/sh

apt-cache search linux-image 2>/dev/null|grep -v '\(dbg\|unsigned\|cloud\|-rt-\)'|grep '(signed)'|sed 's/.*linux/linux/'|sed 's/amd64.*/amd64/' | tee avail_kernels.txt
