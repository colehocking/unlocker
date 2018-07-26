#!/bin/bash

# Unlock and mount a bitlocker-encrypted windows drive onto a linux box
# -- Cole Hocking

# Get the drive to unlock
get_drive(){
    if [[ -f $(which lsblk) ]]; then
        lsblk
    fi
    
    echo -e "\n Which disk would you like to unlock?"
    echo '(Hint: if the windows drive is at /dev/sdb then you would unlock /dev/sdb3)'
    echo "Enter the drive partition to unlock:"    
    read -p '> ' LOCKDRIVE   
}

# Check for dislocker application
check_dislocker(){
    if [[ ! -f $(which dislocker) ]]; then
        echo "dislocker does not appear to be installed"
        echo "Try 'sudo apt install dislocker' or equivalent"
        exit 1
    else
        get_drive
    fi
}

# Get the recovery key from the user
get_key(){
    echo -e "\nEnter the Bitlocker recovery key:"
    read -p '> ' RECKEY 
}

# mount the drive
mount_drive(){
    mkdir -p /mnt/winvol
    mount -o loop,ro /mnt/tmp/dislocker-file /mnt/winvol
    echo 'Success! Windows drive is mounted at /mnt/winvol'   
}

# Unlock the drive
unlock_drive(){
    mkdir -p /mnt/tmp
    dislocker -v -V ${LOCKDRIVE} -p${RECKEY} -- /mnt/tmp
    if [[ ! $(ls /mnt/tmp) == 'dislocker-file' ]]; then    
        echo "Something went wrong. The dislocker-file does not appear to be mounted"
        exit 1
    else
        mount_drive
    fi
}

main(){
    echo "Unlocker:"
    echo "Mount a Bitlocker-encrypted windows drive to a Linux machine"
    echo -e "You will need the Bitlocker recovery key.\n"
    check_dislocker
    get_key
    unlock_drive
}
main
