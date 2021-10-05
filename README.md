#Instaloader-related-scripts
### summary

The following set of bash scripts handle the general saving of Instagram data locally via Instaloader which is a data scraper written in python. So basically these scripts help download and sort both pictures and clips while offering users the able ability to export such data to an external drive.

---
#### Note the following will only work if python and bash are already installed on a given system. And you don't need these scripts to take advantage of the instaloader lib. Read more @ https://instaloader.github.io/
---
### script details
---
gram = runs main.sh <br>
gram -r = runs rerun.sh<br>
gram -move = runs move.sh<br>
gram -clear = runs clear.sh<br>
gram -check = runs check.sh<br>
gram -reset = reset download states for rerun scripts<br>
gram -trash = runs trash.sh

---
**setup** -->
1. cd's into root and seeks the following directories "Picture/0gram", if not present then its creates them. <br>
2. Installs all required packages if any are missing. <br>
3. creates if missing or appends to .bashrc the following commands. <br>

**main.sh** --> takes command line args in the form of username or the keyword "login" and then the username. Note that a given user name has to be written to a ".env" file in order to login to your account before hand. Downloads and sorts files based on if they are jpg or mp4 into 0clips or 0pictues sub-directories while providing file backups of size 0 in the root of profile directory being downloading to avoid duplicate downloads. Additionally if a profile if private then the given directory will be move out into “Pictures/1gram_private” and will require you to be logged into to download such data. 

**rerun.sh** --> used to auto download all the newest data for the given profiles already in the "Picture/0gram" directories. 

**timer.sh** --> is termal visual version of the unix/linux sleep command which displays a live count down

**move.sh** --> presents users with a prompt for all external drives currently plugged in. Note exam the names of the drives and enter the number of the drive upon which the files are to be moved to.

**clear-all.sh** --> deletes all pictures and clips that are saved locally within Picture/0gram.

**check.sh** --> lists all profile directories that are not empty and prompts users with options for opening such directories.

**trash.sh** --> takes 1 command line arg and deletes a given dir and all related files'
