#!/bin/bash
# Author: Philip J. Kazanjian * Boston MA * 01/02/2021 *
# Src: * http://thekettlemaker.com/progressbar.html * https://github.com/PKazanjian/progressbar *
# Desc: A progressbar used to track the progress of extracting any zip file
# Ack: ProgressBar function, fork of Teddy Skarin * https://github.com/fearside/ProgressBar/ *
#
#    205MiB 84MiB/s 00:02 [========================================>] 100% ETA 2
#
_current=0 _elapsed="00:00" _holder="ETA"
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
tar -zxf "${1}" > /dev/null 2>&1 &
_zip=$(gunzip -l "${1}" | awk 'FNR == 2 {print $1}' | numfmt --to=si | sed 's/[a-z]//i')
_extracted=$(gunzip -l "${1}" | awk 'FNR == 2 {print $2}' | numfmt --to=si | sed 's/[a-z]//i')
_fname=$(echo "${1}" | sed s/.tar.*//)
ProgressBar () {
    _percent=$(("${1}*100/${_extracted}*100"/100))
    _mbs=$((${1}/${2}))
    _holder="${5}"
    _eta="${4}"
    _pid=$(pgrep tar)
    _elapsed=$(ps -p "${_pid}" -o etime --no-headers 2>/dev/null)
    _progress=$(("${_percent}*4"/10))
    _remainder=$((40-_progress))
    _completed=$(printf "%${_progress}s")
    _left=$(printf "%${_remainder}s")
    printf "\r${_zip}MiB ${_mbs}MiB/s ${3} [${_completed// /=}>${_left// / }] ${_percent}%% ${_holder} ${_eta} "
}
while [ "${_current}" -lt "${_extracted}" ]; do
    sleep 1
    _sec=$((_sec+1))
    _current=$(du -sh "${_fname}" | sed "s/M.*//" | awk '{print int($1)}')
    if [ "${_current}" -gt "${_extracted}" ] || [ "$((5+_current))" -ge "${_extracted}" ]; then
      _current=${_extracted}
    fi
     if [ "${_sec}" == 1 ]; then 
      _eta=$(("${_extracted}/${_current}"))
    fi
     if [[ "${_sec}" -gt 1 && "${_eta}" != 0 ]]; then
      _eta=$((_eta-1))
      _last=${_elapsed}
    fi
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
