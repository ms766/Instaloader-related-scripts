#!/usr/bin/env bash
#running bash 4
reset=$(tput sgr0); black=$(tput setaf 0);blue=$(tput setaf 33);
cyan=$(tput setaf 37);green=$(tput setaf 64);orange=$(tput setaf 166);
purple=$(tput setaf 125);red=$(tput setaf 124);violet=$(tput setaf 61);
white=$(tput setaf 15);yellow=$(tput setaf 136);
#--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--#

chmod -R 777 ./

instaloadercheck=`pip3 freeze | grep "instaloader"`

if [[ "$instaloadercheck" == "" ]]; then
    pip3 install instaloader
    pip3 install --upgrade instaloader
else
    echo "instaloader installed already"
fi

#jump to root dir
cwd=`pwd`

#check for scripts directory
function scriptscheck(){
while true;
do
cd
if [ -d "scripts" ]; then
    cd "scripts"
    if [ -d "gram" ]; then
       echo ${yellow}"All relevant script present & ready for use"${reset}
       return 0
    else
       echo ${yellow}"All relevant script loaded & ready for use"${reset}
       cp -r "$cwd" "."
       return 0
    fi
else
    mkdir "scripts"
fi
done
}
scriptscheck

cd

#check for pics dir
if [ -d 'Pictures' ]; then
  cd "Pictures"
  #check if 0gram dir exist
  if [ -d '0gram' ]; then
     echo ${green}"All relevant directories present"${reset}
   else
     echo ${green}"All relevant directories loaded – base setup complete!"${reset}
     mkdir "0gram"
  fi
else
  mkdir "Pictures"
  cd "Pictures"
  mkdir "0gram"
  echo ${green}"All relevant directories present – base setup complete!"${reset}
fi

rm -r "$cwd"

cd
bashrc_check=`cat ".bashrc" | grep "instaloader"`
if [[ $bashrc_check == "" ]]; then
cat >> .bashrc << END
function instgramDL(){
	if [[ "\$1" == '-r' ]]; then
		cd ~/scripts/gram && ./rerun.sh && cd ~/Desktop
	elif [[ "\$1" == '-clear' ]]; then
		cd ~/scripts/gram && ./dump.sh && cd ~/Desktop
	elif [[ "\$1" == '-check' ]]; then
		cd ~/scripts/gram && ./update-checker.sh && cd ~/Desktop
	elif [[ "\$1" == '-move' ]]; then
			cd ~/scripts/gram && ./move.sh && cd ~/Desktop
	elif [[ "\$1" == '-reset' ]]; then
				cd ~/Pictures/0gram && rm currentStatelist.txt gramList.txt statelist.txt && cd ~/Desktop
	elif [[ "\$1" == '-trash' ]]; then
					cd ~/scripts/gram && ./junk_collector-driver.sh $1 && cd ~/Desktop
  elif [[ "\$1" == '-help' ]]; then
    echo 'Enter: -clear -> clears all dirs'
    echo 'Enter: -check -> checks each dir download state'
    echo 'Enter: -move -> copies all files > 0 to chosen dir'
    echo 'Enter: -reset -> deletes all states in terms of downloads'
    echo 'Enter: -trash -> deletes a given dir and all related files'
	else
	cd ~/scripts/gram && ./main.sh \$@ && cd ~/Desktop
	fi
}

alias gram="instgramDL"
END
fi

