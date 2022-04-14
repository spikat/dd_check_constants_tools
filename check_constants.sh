#!/bin/bash

KERN=$(uname -r)

if [ ! -f testsuite ]; then 
    echo "ERROR: testsuite is missing"
    exit 1
else
    echo "CHECK FOR $KERN:" | tee $KERN.res
    sudo ./testsuite -test.v -test.run TestOctogonConstants | tee -a $KERN.res
fi
exit 0
