#!/bin/sh
# set the battery charging thresholds to extend battery lifespan
echo 90 > /sys/class/power_supply/BAT0/charge_start_threshold
echo 100 > /sys/class/power_supply/BAT0/charge_stop_threshold
