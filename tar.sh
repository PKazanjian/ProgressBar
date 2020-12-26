#!/bin/bash
# Author: Philip J. Kazanjian * Boston MA * 12/26/2020 *
# Src: * http://thekettlemaker.com/progressbar.html * https://github.com/PKazanjian/progressbar *
# Desc: A progressbar used to track the progress of extracting a zip file 
# Ack: ProgressBar function, fork of Teddy Skarin * https://github.com/fearside/ProgressBar/ *
#
_f100=336
_current=0
echo ""
printf '\e[1;34m%-6s\e[m' "Extracting File..."
echo "
"
tput civis
stty -echo
CleanUp () {
   tput cnorm
   stty echo
}
trap CleanUp EXIT
sudo tar -zxf hadoop-2.7.3.tar.gz > /dev/null 2>&1 &
ProgressBar () {
    _percent=$(("${1}*100/${_f100}*100"/100))
    _eta="ETA $((8-"${_percent}*8/100"))s"
    _elapsed=$(ps -p $! -o etime --no-headers)
    _progress=$(("${_percent}*4"/10))
    _remainder=$((40-_progress))
    _completed=$(printf "%${_progress}s")
    _left=$(printf "%${_remainder}s")
    printf "\rProgress : [${_completed// /=}>${_left// / }] ${_percent}%% ${2} ${3}"
}
while [ "${_current}" -lt "${_f100}" ]
do
    sleep 0.2
    _current=$(sudo du -sh hadoop-2.7.3 | sed "s/M.*//")
    if [ "${_elapsed}" ]
     then
      _last="$_elapsed"
    fi
    ProgressBar "${_current}" "${_elapsed//[[:blank:]]/}" "${_eta}"
done
    if [ "${_eta}" == "ETA 0s" ]
     then
      _eta="      "
    fi
    ProgressBar "${_current}" "${_last//[[:blank:]]/}" "${_eta}" 
echo "
"
printf '\e[0;32m%-6s\e[m' "$(tput bold)Done!!"
echo "
"
# EOF
