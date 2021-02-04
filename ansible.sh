#!/usr/bin/env bash

if [ ! -n "$1" ] ; then
	echo 'Missing argument: new_hostname'
	exit 1
fi

if [ "$(id -u)" != "0" ] ; then
	echo "Sorry, you are not root."
	exit 2
fi

#install SSH services
#sudo apt install -y openssh-server 
sudo pacman -Syu

#ipdetails
#ip="$(ip -o -4 addr list enp1s0 | awk '{print $4}' | cut -d/ -f1)"
ip="$(ip -o -4 addr list wlp3s0 | awk '{print $4}' | cut -d/ -f1)"

# Display the current hostname
CUR_HOSTNAME=$(cat /etc/hostname)
echo "The current hostname is $CUR_HOSTNAME"
NEW_HOSTNAME=$1

# Change the hostname
hostnamectl set-hostname $NEW_HOSTNAME
hostname $NEW_HOSTNAME

# Change hostname in /etc/hosts & /etc/hostname
sudo sed -i "s/$CUR_HOSTNAME/$NEW_HOSTNAME/g" /etc/hosts
sudo sed -i "s/$CUR_HOSTNAME/$NEW_HOSTNAME/g" /etc/hostname
echo "The new hostname is $NEW_HOSTNAME and IP address is $ip please copy the below details"
echo "$NEW_HOSTNAME $ip"
