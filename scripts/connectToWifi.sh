#!/bin/bash
sudo wpa_supplicant -B -i wlp0s20f3 -c /etc/wpa_supplicant/a.conf
sudo dhcpcd wlp0s20f3
sudo netctl start ethernet
