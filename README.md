# BASH progressbars for processes and APIs
## Example: "processes.sh" displays the progress of 15 containers starting
If you wish to measure the progress of your containers just edit these two items:
1. Change the \_f100 variable on line 6 to number of your total containers produced by your command or commands (see line 21)
2. Change the command on line 21 to the command or commands used to start your containers and append > /dev/null 2>&1 & to each one

To see examples: http://thekettlemaker.com/progressbar.html

## Example: "apis.sh" displays the progress of 22 containers starting and when 17 APIs are ready
If you wish to measure the progress of different APIs, then change these four items:
1. Change the command on line 24 to your command or commands used to start your containers and append > /dev/null 2>&1 & to each one
2. Change the y variable on line 8 to number of your total containers produced by your command or commands (see line 24)
3. Change the \_f100 varible on line 7 to include the total containers + total APIs
4. Change the command used to test API status on line 46 and change the filter to look for "ready" messages

This video will walk you thru it!
https://www.youtube.com/watch?v=VxmL_6eX7Pw

## Example: "tar.sh" displays the progress of extracting a specific zip file

205MiB 84MiB/s 00:02 [========================================>] 100% ETA 2
  
To use this with your file:
1. Replace your tar file with the one specified on line 20
2. Replace the extracted file's disk usage in MB on line 7 "_f100"
3. Replace the estimated time values on line 23. For me it was "4" seconds. This was determined using time (See below YouTube video)
4. Run the script as "root"

To do's (Allow the script to be used to with any zip file):
1. Automate file by passing as argument to script
2. Automate determining extracted "Disk Usage".. maybe using gzip or unzip
3. Automate ETA

YouTube video will follow shortly : )
