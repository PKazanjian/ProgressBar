#!/bin/bash
# Author: Philip J. Kazanjian * Boston MA * 08/21/2020 *
# Src: * http://thekettlemaker.com/progressbar.html * https://github.com/PKazanjian/ProgressBar *
# Desc: A progressbar for displaying the progress of 22 containers starting and when 17 APIs are ready
# Ack: ProgressBar function, fork of Teddy Skarin * https://github.com/fearside/ProgressBar/ *
#
_f100=39
_current=0 i=0 j=0 k=0 x=75 y=22 z=5
_spin="┤┘┴└├┌┬┐"
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
   rm /tmp/count
}
trap CleanUp EXIT
touch /tmp/count
docker-topo --create my-topology.yml > /dev/null 2>&1 &
ProgressBar () {
   _percent=$(("${1}*100/${_f100}*100"/100))
   _progress=$(("${_percent}*4"/10))
   _remainder=$((40-_progress))
   _completed=$(printf "%${_progress}s")
   _left=$(printf "%${_remainder}s")
   printf "\rProgress : [\e[42m\e[30m${_completed// /▒}\e[0m${a}${_spin:i++%${#_spin}:1}${b}${_left// /=}] ${_percent}%%"
}
while [ "${_current}" -lt "${_f100}" ]
do
  if [ "${_current}" -lt "$y" ]; then
      if [ "$k" -lt "$z" ]; then
        k=$((k+1))
      fi
      if [ "$k" = "$z" ]; then
        _containers=$(docker ps -q | wc -l)
        k=$((k=0))
      fi
   fi
   if [ "${_current}" -ge "$y" ]; then
      if [ "$j" = "$x" ]; then
        ansible -m eos_command -a "commands='show lldp neighbors' provider='{{ eos_connection }}'" all | grep -ic success >> /tmp/count &
        j=$((j=0))
      fi
      if [ "$j" -lt "$x" ]; then
        j=$((j+1))
        _apis=$(tail -n 1 /tmp/count)
      fi
   fi
     sleep 0.75
     _current=$((_containers + _apis))
    if [ "${_current}" = "${_f100}" ]; then
       _spin="▒"
       a="\e[42m\e[30m"
       b="\e[0m"
    fi
     ProgressBar "${_current}"
done
echo "
"
printf '\e[0;32m%-6s\e[m' "$(tput bold)APIs are Ready!!"
echo "
"
# EOF
