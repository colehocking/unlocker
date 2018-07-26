# Unlocker

- Mount a bitlocker-encrypted Windows drive to a Linux machine.  


### Requirements  
- dislocker application (try `sudo apt install dislocker` or similar).    
- These scripts assume super-user privileges without invoking `sudo`.    
- If not on Kali, run `sudo su -` first.  
- You will also need the bitlocker recovery key.  


### Usage  
- `./unlocker.sh`. You will be asked for the drive to unlock, as well as the recovery key.
- Run `./cleanup.sh` when you are finished. This will unmount the drives and remove the directories created at /mnt/. Then you can safely disconnect the drive.  

