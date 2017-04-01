#!/bin/bash
# ClusterHAT controller

if [ $# -gt 0 ];then
	MODE=$1
else
	echo
	echo "Usage:"
	echo " $0 <action> [<device>] [<device>]"
	echo " action = on / off"
	echo " device = all / p1 / p2 / p3 / p4"
	echo " If device is missing the action will be performed on all devices"
	echo
	echo "Examples:"
	echo "$0 on p1 p3 # Turns on P1 and P3"
	echo "$0 off all # Turns off P1-4"
	echo
	exit
fi

if [ $# -gt 1 ]; then
        devices=("$@")
else
        devices=("all")
fi

function contains() {
        local n=$#
        local value=${!n}
        for ((i=1;i < $#;i++)) {
                if [ "${!i}" == "${value}" ]; then
                        echo "y"
                        return 0
                fi
        }
        echo "n"
        return 1
}


if [ "$MODE" = "on" ]; then
# Turn "Alert" LED on whilst we're running
gpio write 21 1

if [[ $(contains "${devices[@]}" "all") == "y" ]] || [[ $(contains "${devices[@]}" "p1") == "y" ]];then
echo "Turning on P1"
gpio write 22 1
sleep 2
fi

if [[ $(contains "${devices[@]}" "all") == "y" ]] || [[ $(contains "${devices[@]}" "p2") == "y" ]];then
echo "Turning on P2"
gpio write 23 1
sleep 2
fi

if [[ $(contains "${devices[@]}" "all") == "y" ]] || [[ $(contains "${devices[@]}" "p3") == "y" ]];then
echo "Turning on P3"
gpio write 24 1
sleep 2
fi

if [[ $(contains "${devices[@]}" "all") == "y" ]] || [[ $(contains "${devices[@]}" "p4") == "y" ]];then
echo "Turning on P4"
gpio write 25 1
sleep 2
fi

# Turn "Alert" LED off
gpio write 21 0

elif [ "$MODE" = "off" ];then
# Turn "Alert" LED on whilst we're running
gpio write 21 1

if [[ $(contains "${devices[@]}" "all") == "y" ]] || [[ $(contains "${devices[@]}" "p1") == "y" ]];then
	echo "Turning off P1"
	gpio write 22 0
fi

if [[ $(contains "${devices[@]}" "all") == "y" ]] || [[ $(contains "${devices[@]}" "p2") == "y" ]];then
	echo "Turning off P2"
	gpio write 23 0
fi

if [[ $(contains "${devices[@]}" "all") == "y" ]] || [[ $(contains "${devices[@]}" "p3") == "y" ]];then
	echo "Turning off P3"
	gpio write 24 0
fi

if [[ $(contains "${devices[@]}" "all") == "y" ]] || [[ $(contains "${devices[@]}" "p4") == "y" ]];then
	echo "Turning off P4"
	gpio write 25 0
fi

# Turn "Alert" LED off
gpio write 21 0

else
	echo "ERROR: Unknown Mode"
	exit
fi

