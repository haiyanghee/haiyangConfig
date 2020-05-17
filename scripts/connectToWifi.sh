#!/bin/bash
sudo wpa_supplicant -B -i wlp1s0 -c /etc/wpa_supplicant/wpa_supplicant-net.conf
sudo dhcpcd wlp1s0
#start ethernet
#sudo netctl start ethernet
