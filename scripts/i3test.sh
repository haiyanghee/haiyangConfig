#!/bin/bash
allWS=$(i3-msg -t get_workspaces | tr , '\n' | grep -E '"num"|"visible":true' | cut -d : -f 2)

tempWs=0
for char in $allWS
do
	if [ $char = "true" ]
	then
		#echo "i'm in!"
		break
	fi
	tempWs=$char
	#echo "end one iteration"
done
echo $tempWs
((tempWs++))
i3-msg move container to workspace $tempWs
