#!/bin/bash
# Author: Philip J. Kazanjian * Boston MA * 07/31/2020 *
# Src: * http://thekettlemaker.com/progressbar.html * https://github.com/PKazanjian/progressbar *
# Desc: Displays the progress of 15 containers starting
# Ack: ProgressBar function, fork of Teddy Skarin * https://github.com/fearside/ProgressBar/ *
#
_f100=15
_current=0 i=0
_spin="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
declare a b
echo ""
printf '\e[1;34m%-6s\e[m' "Spawning Containers"
echo "
"
tput civis
stty -echo
CleanUp () {
   tput cnorm
   stty echo
}
trap CleanUp EXIT
docker-topo --create my-topology.yml > /dev/null 2>&1 &
ProgressBar () {
   _percent=$(("${1}*100/${_f100}*100"/100))
   _progress=$(("${_percent}*4"/10))
   _remainder=$((40-_progress))
   _completed=$(printf "%${_progress}s")
   _left=$(printf "%${_remainder}s")
   printf "\rProgress : [\e[42m\e[30m${_completed// /#}\e[0m${a}${_spin:i++%${#_spin}:1}${b}${_left// /-}] ${_percent}%%"
}
while [ "${_current}" -lt "${_f100}" ]
do
   sleep 1
   _current=$(docker ps -q | wc -l)
    if [ "${_current}" = "${_f100}" ]
      then
       _spin="#"
       a="\e[42m\e[30m"
       b="\e[0m"  
    fi
      ProgressBar "${_current}"
done
echo "
"
printf '\e[0;32m%-6s\e[m' "$(tput bold)Containers are Ready!!"
echo "
"
# EOF
