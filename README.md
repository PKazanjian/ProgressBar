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

## Example: "tar.sh" displays the progress of extracting a zip file
