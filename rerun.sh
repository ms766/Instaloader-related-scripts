#!/usr/bin/env bash
#running bash 4
#################################
reset=$(tput sgr0); black=$(tput setaf 0);blue=$(tput setaf 33);
cyan=$(tput setaf 37);green=$(tput setaf 64);orange=$(tput setaf 166);
purple=$(tput setaf 125);red=$(tput setaf 124);violet=$(tput setaf 61);
white=$(tput setaf 15);yellow=$(tput setaf 136);
#################################
cd && cd "Pictures" && cd "0gram";
#################################
startTime=`date "+%I:%M %p"`

ls -d */ | cut -f1 -d'/' | sort > gramList.txt


if [[ ! -f statelist.txt ]]; then
  inList='./gramList.txt'
  touch statelist.txt
else
  cat gramList.txt >> finList.txt && cat statelist.txt >> finList.txt
  sort finList.txt | uniq -u > currentStatelist.txt
  rm finList.txt
  inList='./currentStatelist.txt'
fi


while IFS= read -r line
do
     echo ${red}"$line"${reset}; echo
     #---->
     ~/scripts/gram/main.sh $line
     ~/scripts/timer.sh 00 00 01
     clear && printf '\e[3J'
     echo
     echo ${yellow}"Next download start's in 1 seconds"${Reset}
     ~/scripts/timer.sh 00 00 01 && echo && echo

     stateCount=`grep -o -c $line 'statelist.txt'`
     if [[ $stateCount == 0 ]]; then
         echo $line >> statelist.txt
     fi

     gCount=`cat 'gramList.txt' | wc -l | xargs`
     sCount=`cat 'statelist.txt' | wc -l | xargs`
     # echo $sCount $gCount
     # sleep 30
     if [[ $sCount == $gCount ]]; then
        rm 'statelist.txt'
        rm 'currentStatelist.txt'
        rm 'gramList.txt'
     fi
done < $inList


clear && printf '\e[3J'
echo ${green}"All Downloads Complete"${reset}
endTime=`date "+%I:%M %p"`
echo
echo ${orange}"startTime:$startTime"${reset}
echo ${orange}"endTime:$endTime"${Reset}
