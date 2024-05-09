#!/bin/bashSSS
# Author - Ken Lam

#------------------------
#Initialize the color shortcuts

DEF='\033[0;m'

BLINKING='\033[5;1m'
UNDERLINE='\033[4m'

CYAN1='\033[1;36m'
GREEN1='\033[1;32m'
ORANGE1='\033[1;33m'
WHITE1='\033[1;1m'
RED1='\033[1;31m'

#------------------------
#Prologue for user

echo "This script will display Linux Operating System Information of this machine."
echo "Note: sudo is required to run this script and you may be asked to input your password."
echo -e "\nProcessing your request..."

#------------------------
# initialize all variables

checksudo="`id | grep sudo`"
if [ -z "$checksudo" ]
then
	#empty
	echo "ERROR: Request failed!"
	echo "Please make sure the User is under sudo group before running the script."
	exit
else
	#not empty
	topfivedir="`sudo du -ah / | sort -rh | head -5`"
fi

verlinuxname="`cat /etc/os-release | grep PRETTY_NAME | awk -F '"' '{print $(2)}'`"
verlinuxid="$(cat /etc/os-release | grep VERSION_ID | awk -F '"' '{print $(2)}')"

ippublic="$(curl ifconfig.me)"
ipprivate="`ifconfig | grep inet | head -n 1 | awk '{print $(2)}'`"
ipdefaultgateway="`route | grep default | awk '{print $(2)}'`"

harddisksize="`df -h | grep sda | awk '{print $(2)}'`"
harddisksizefree="`df -h | grep sda | awk '{print $(4)}'`"
harddisksizeused="`df -h | grep sda | awk '{print $(3)}'`"

#------------------------
# Print results

echo -e "\n${DEF}Almost there..."
sleep 1
echo -e "\nAlright, we're done!"
sleep 1

echo -e "\n-----------------------------"
echo -e "${WHITE1}Linux Operating System Information${DEF}"
echo -e "-----------------------------\n"

echo -e "Linux Version : ${CYAN1}$verlinuxname - $verlinuxid${DEF}"

sleep 1
echo -e "\nPrivate IP address : ${ORANGE1}$ipprivate${DEF}"
echo -e "Public IP address : ${ORANGE1}$ippublic${DEF}"
echo -e "Default gateway : ${ORANGE1}$ipdefaultgateway${DEF}"

sleep 1
echo -e "\nHard Disk Size : ${WHITE1} $harddisksize ${DEF}"
echo -e "Hard Disk Used Space : ${RED1}$harddisksizeused${DEF}"
echo -e "Hard Disk Free Space : ${GREEN1}$harddisksizefree${DEF}"

sleep 1
echo -e "\n${UNDERLINE}Top 5 Directories and Size:${DEF}\n\n$topfivedir"

#-----------------------------------------------
#Display CPU Usage, refreshed every 10 seconds
sleep 1
echo -e "\n${UNDERLINE}Displaying CPU Usage${DEF}\n(${BLINKING}refreshed every 10 seconds${DEF})"
echo -e "\nTo stop running, press CTRL+C\n"
sar -u 10
