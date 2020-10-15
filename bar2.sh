#!/bin/bash

#	    __                               ____            
#	   / /   ___  ____ ___  ____  ____  / __ )____ ______
#	  / /   / _ \/ __ `__ \/ __ \/ __ \/ __  / __ `/ ___/
#	 / /___/  __/ / / / / / /_/ / / / / /_/ / /_/ / /    
#	/_____/\___/_/ /_/ /_/\____/_/ /_/_____/\__,_/_/     
#	

source ~/.cache/wal/colors.sh

# Colors
crit='#BF616A'
warn='#EBCB8B'
norm='#A3BE8C'
void='#B48EAD'

# Icons
iUser='\uf2bd'		#  
#--------------------------#
iVolumeFull='\uf028'	#  
iVolumePart='\uf027'	#  
iVolumeNone='\uf026'	#  
#--------------------------#
iBatteryFull='\uf240'	#  
iBattery4='\uf240'	#  
iBattery3='\uf240'	#  
iBattery2='\uf240'	#  
iBattery1='\uf240'	#  
iCharge='\uf0e7'	#  
#--------------------------#
iGlobe='\uf484'		#  
iClock='\ue381'		#  
iTemp='\ue265'		#  
iOS='\uf303'		#  

User(){
	echo -e "%{F$color1}$iUser $USER "
}
Host(){
	echo -e "%{F$color2}$iOS $HOSTNAME"
}
Volume(){
	state=$(echo -e $(amixer get Master | grep % | cut -d' ' -f8 | tr -d [:punct:]))
	vol=$(echo -e $(amixer get Master | grep % | cut -d' ' -f6 | tr -d [:punct:]))

	if [[ $state == *"off"* ]]
	then
		echo "%{F$void}$iVolumeNone MUTED"
	elif [[ $state == *"on"* ]]
	then
		if [ $vol -le "25" ]; then
			echo -e "%{F$crit}$iVolumePart $vol  "
		elif [ $vol -le "50" ]; then
			echo -e "%{F$warn}$iVolumePart $vol  "
		elif [ $vol -le "75" ]; then
			echo -e "%{F$warn}$iVolumePart $vol  "
		elif [ $vol -le "100" ]; then
			echo -e "%{F$norm}$iVolumeFull $vol  "
		elif [ $vol -eq "0" ]; then
			echo -e %{F$void}"$iVolumeNone $vol  "
		fi
	fi
}
Battery(){
	echo -e "%{F$color4}$iBatteryFull $(acpi | cut -d, -f2) "
}
PublicIP(){
	echo -e "%{F$color5}$iGlobe $(curl icanhazip.com) "
}
Clock(){
	echo -e "%{F$color6}$iClock $(date "+%I:%M") "
}
Temperature(){
	echo -e "%{F$color5}$iTemp $(sensors | grep lake -A2 | grep temp | cut -d: -f2 | tr -d '[:space:]') "
}

while true; do
	echo -e "%{l}$(PublicIP)%{c}%{r}$(Volume)$(Temperature)$(Battery)"
	sleep 1s
done
