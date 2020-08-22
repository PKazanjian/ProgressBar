# BASH progressbars for processes and APIs
## Example: "processes.sh" displays the progress of 15 containers starting
If you wish to measure the progress of something else, change these three items:
1. Change the \_f100 variable on line 6 to reflect what 100% should be 
2. Change the command on line 21 (In my case it was used to spin up 15 containers)
3. Change the \_current variable on line 33 (In my case it was set to a command to determine the number of running containers)

To see examples: http://thekettlemaker.com/progressbar.html
