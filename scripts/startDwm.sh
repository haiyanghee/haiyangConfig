#!/bin/bash
while true; do
    # Log stderror to a file 
    dwm >> ~/.dwm.log
    # No error logging
    #dwm >/dev/null 2>&1
done
