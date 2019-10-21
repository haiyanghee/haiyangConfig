#!/bin/sh
# set the battery charging thresholds to extend battery lifespan
echo ${2:-90} > /sys/class/power_supply//BAT${1:-0}/charge_start_threshold
echo ${3:-100} > /sys/class/power_supply//BAT${1:-0}/charge_stop_threshold
