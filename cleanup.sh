#!/bin/bash

# Unmount and remove the mount drives when finished

umount /mnt/winvol/ 2>/dev/null
umount /mnt/tmp/ 2>/dev/null

rm -rf /mnt/winvol/
rm -rf /mnt/tmp/

echo 'Done!'
