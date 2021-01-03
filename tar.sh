#!/bin/bash
# Author: Philip J. Kazanjian * Boston MA * 12/26/2020 *
# Src: * http://thekettlemaker.com/progressbar.html * https://github.com/PKazanjian/progressbar *
# Desc: A progressbar used to track the progress of extracting a specific zip file 
# Ack: ProgressBar function, fork of Teddy Skarin * https://github.com/fearside/ProgressBar/ *
#      205MiB 84MiB/s 00:02 [========================================>] 100% ETA 2
#
_f100=336 _current=0 _elapsed="00:00" _holder="ETA"
_mib=$(du -sh hadoop-2.7.3.tar.gz | sed "s/M.*//")
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
tar -zxf hadoop-2.7.3.tar.gz > /dev/null 2>&1 &
ProgressBar () {
    _percent=$(("${1}*100/${_f100}*100"/100))
    _mbs=$((${1}/${2}))
    _holder="${5}"
    _eta="${4}"
    _pid=$(pgrep tar)
    _elapsed=$(ps -p "${_pid}" -o etime --no-headers 2>/dev/null)
    _progress=$(("${_percent}*4"/10))
    _remainder=$((40-_progress))
    _completed=$(printf "%${_progress}s")
    _left=$(printf "%${_remainder}s")
    printf "\r${_mib}MiB ${_mbs}MiB/s ${3} [${_completed// /=}>${_left// / }] ${_percent}%% ${_holder} ${_eta} "
}
while [ "${_current}" -lt "${_f100}" ]; do
    sleep 1
    _sec=$((_sec+1))
    _current=$(du -sh hadoop-2.7.3 | sed "s/M.*//" | awk '{print int($1)}')
     if [ "${_sec}" == 1 ]; then 
      _eta=$(("${_f100}/${_current}"))
    fi
     if [[ "${_sec}" -gt 1 && "${_eta}" != 0 ]]; then
      _eta=$((_eta-1))
    fi
    _last=${_elapsed}
    ProgressBar "${_current}" "${_sec}" "${_elapsed//[[:blank:]]/}" "${_eta}" "${_holder}"
done
_eta=" " _holder="   "
ProgressBar "${_current}" "${_sec}" "${_last//[[:blank:]]/}" "${_eta}" "${_holder}"
echo "
"
printf '\e[0;32m%-6s\e[m' "$(tput bold)Done!!"
echo "
"
# EOF
