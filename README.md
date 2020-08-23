# BASH progressbars for processes and APIs
## Example: "processes.sh" displays the progress of 15 containers starting
If you wish to measure the progress of something else, change these three items:
1. Change the \_f100 variable on line 6 to reflect what 100% should be 
2. Change the command on line 21 (In my case it was used to spin up 15 containers) and append > /dev/null 2>&1 &
3. Change the \_current variable on line 33 (In my case it was set to a command to determine the number of running containers)

To see examples: http://thekettlemaker.com/progressbar.html

## Example: "apis.sh" displays the progress of 22 containers starting and when 17 APIs are ready
If you wish to measure the progress of something else, change these four items:
1. Change the command on line 24 to your command or commands used to start your containers
2. Change the y variable on 8 to reflect 100 % of your total containers should be
3. Change the \_f100 varible on line 7 to include the total containers + total APIs
4. Change the command used to test API status on line 46 and filter for a message that is provided by your command

This video will walk you thru it!
https://www.youtube.com/watch?v=VxmL_6eX7Pw

