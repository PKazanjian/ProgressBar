#!/bin/bash
# Author: Philip J. Kazanjian * Boston MA * 07/31/2020 *
# Src: * http://thekettlemaker.com/progressbar.html * https://github.com/PKazanjian/progressbar *
# Ack: ProgressBar function, fork of Teddy Skarin * https://github.com/fearside/ProgressBar/ *
#
_f100=15
_current=0
_spin="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
i=0
echo ""
printf '\e[1;34m%-6s\e[m' "Spawning Containers"
echo "
"
tput civis
stty -echo
trap ctrl_c INT
ctrl_c () {
   tput cnorm
   stty echo
   echo "
   "
   exit $?
}
ProgressBar () {
   _percent=$(("${1}*100/${_f100}*100"/100))
   _progress=$(("${_percent}*4"/10))
   _remainder=$((40-_progress))
   _completed=$(printf "%${_progress}s")
   _left=$(printf "%${_remainder}s")
   printf "\rProgress : [\e[42m\e[30m${_completed// /#}\e[0m${_cspin}${_left// /-}] ${_percent}%%"
}
while [ "${_current}" -lt "${_f100}" ]
do
   sleep 1
   _current=$(wc -l < count)
    if [ "${_current}" = "${_f100}" ]
      then
       _spin="#"
       _cspin="\e[42m\e[30m${_spin:i++%${#_spin}:1}\e[0m"
      else
       _cspin="${_spin:i++%${#_spin}:1}"    
    fi
      ProgressBar "${_current}"
done
stty echo
tput cnorm
echo "
"
printf '\e[0;32m%-6s\e[m' "$(tput bold)Containers are Ready!!"
echo "
"
exit $?
