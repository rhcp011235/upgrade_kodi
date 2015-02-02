#!/bin/bash
#
# Simple upgrade tool to update XBMC across your entire network.
#
# I got way too lazy to do this all alone. This is for android devices aka FireTv and FireTvStick and others that have adb port 5555 open
#
# Feel free to modify and push changes to this git. I just wrote this up in 30 seconds
# 
# john.b.hale@gmail.com
# 2/2/2015

ADB=`which adb`
FIRMWARE=$1

# Arry of my devices
# Right now you have to enter them in manually. I have not found a way to make an bash array via arp.
# idea was: arp -a|grep android|cut -d' ' -f2|cut -d'(' -f2|cut -d')' -f1 
IPS=( '192.168.2.111' '192.168.2.118' '192.168.2.129' )


# Lets make sure there is no ADB started
$ADB kill-server

# Setup the loop for the interesting stuff
ELEMENTS=${#IPS[@]}
for (( i=0;i<$ELEMENTS;i++)); 
do
    $ADB connect ${IPS[${i}]}
    $ADB install -r $1
    $ADB kill-server
done

# we are done
echo All done upgrading all your xbmc devices to $1 



# lets kill adb
$ADB kill-server
