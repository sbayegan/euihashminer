#!/bin/bash
# August Miner Setup Prototype

if ! [ -e "requirements" ]
then
echo "Updating packages"
sudo apt-get update 
clear
echo "Installing gcc"
sudo apt-get install gcc
clear
echo "Installing make"
sudo apt-get install make
clear
echo "Installing g++"
sudo apt-get install g++
clear

touch requirements
fi

if ! [ -e "restart" ]
then
	sudo bash -c "echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
	sudo bash -c "echo options nouveau modeset=0 >> /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
	sudo update-initramfs -u
	touch restart
	sudo reboot now
fi

if ! [ -e "cuda_10.0.130_410.48_linux.run" ]
then
echo "Download CUDA drivers"
wget https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux -O cuda_10.0.130_410.48_linux.run
clear
fi

echo "Initiating CUDA driver installation"
sudo sh cuda_10.0.130_410.48_linux.run

cp /dev/null /etc/modprobe.d/blacklist-nvidia-nouveau.conf
sudo update-initramfs -u
sudo reboot now
