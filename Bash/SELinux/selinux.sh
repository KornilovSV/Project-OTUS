#!/bin/bash
# Block 1. Checking the rights to change the SELinux mode.

clear
USER=$(whoami)
WUSER=$(grep wheel /etc/group | grep -o `whoami`)
CMODE=$(getenforce)

if [ $UID -eq 0 ]; then
    echo "You under ROOT"
elif [ $USER == $WUSER ]; then
    echo "You can execute a commands as the superuser."
else
    echo "!!! YOU DON'T HAVE ENOUGH RIGHTS"
    sleep 5
    exit 1
fi
# ----------------------------------------------
# Block 2. Status of SELinux policy
#
clear
echo "Information of SELinux on host: $HOSTNAME"
echo -------------------------
sestatus | grep "SELinux status" && sestatus | grep -A1 "Current mode:"
echo -------------------------

if [ -f /etc/selinux/config.back ]; then
    echo "Backup file present"
    else
    sudo cp /etc/selinux/config /etc/selinux/config.back
fi
# ----------------------------------------------
# Block 3. Menu actions

function help {
#  clear
   echo "Select [e|p|f|d] an action and press Enter."
   echo 
   echo Menu:
   echo "	e	Set "Enforce"    in the current session"
   echo "	p	Set "Permissive" in the current session"
   echo "	f	Set Enforcing mode in the config file"
   echo "	d	Set Disabled in the config file"
   echo "	X	Exit"
}
echo 

if [[ $# -ne 1 ]]; then
    help;
fi

read S1

case $S1 in
    "e")
    sudo setenforce 1
    ;;
    "p")
    sudo setenforce 0
    ;;
    "f")
    sudo sed -i 's/SELINUX=disabled/SELINUX=enforcing/' /etc/selinux/config
    echo "Reboot the host for the changes to take effect"
    echo 
    sleep 5
    ;;
    "d")
    sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
    echo "Reboot the host for the changes to take effect"
    echo 
    sleep 5
    ;;
    "X" | "x")
    exit 1
    ;;
    *)
    help
    ;;
esac

# END
