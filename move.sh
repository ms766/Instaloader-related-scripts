#!/usr/bin/env bash
#running bash 4

reset=$(tput sgr0); black=$(tput setaf 0);blue=$(tput setaf 33);
cyan=$(tput setaf 37);green=$(tput setaf 64);orange=$(tput setaf 166);
purple=$(tput setaf 125);red=$(tput setaf 124);violet=$(tput setaf 61);
white=$(tput setaf 15);yellow=$(tput setaf 136);

cd
if [ -d "Pictures" ];then
  cd "Pictures"
  if [ -d "0gram" ]; then
  cd "0gram"
  echo ${green}"SOURCE DIR PRESENT"${reset}
  pwd
  else
  echo ${red}"NO SOURCE DIR TO DRAW FROM !!!"${reset}
  exit
  fi
fi

mountedVolumes=`df | grep -io '/volumes/.*\|/media.*' | grep -vi '/Volumes/Macintosh HD - Data\|.*/storage\|.*system'`
count=0
progesscount=0
declare -A drives

if [[ $mountedVolumes == '' ]]; then
    echo ${red}'No drives mounted'${reset};echo;
else
  echo
    echo ${yellow}'id: Volume Name'${reset};echo

    for i in $mountedVolumes
    do
      let count+=1
      echo ${cyan}':'$count':' $i${reset};echo;
      drives["$count"]=$i
    done
    echo -n ${reset}"Enter an drive ${yellow}id${reset} from ${cyan}above${reset} regarding ${blue}moving${reset}, ${red}files from ${blue}Local PATH /${red}~/Pictures/0gram${blue}/ ${reset}:-> "${yellow};
    read toDirectory;

    if [[ $toDirectory != '' && " ${drives[@]} " =~ " ${drives[$toDirectory]} " && -d "${drives[$toDirectory]}/0gram" ]]; then
        echo
        echo ${drives[$toDirectory]} ${red}'selected!'${reset}


      cd && cd "~/Pictures/0gram"
      TFcount=`ls -1 | wc -l`; let TFcount+=3;
      SAVEIFS=$IFS
      IFS=$(echo -en "\n\b")
      for i in *
      do
        printf "\r$progesscount out of $TFcount done updating";
        if [[ -d $i && -d "${drives[$toDirectory]}/0gram/$i/0Pictures" ]]; then
              cd $i
              ###########
              SAVEIFS=$IFS
              IFS=$(echo -en "\n\b")
              for junk in *
              do
                  if [[ -f $junk && ! -f "${drives[$toDirectory]}/0gram/$i/$junk" ]]; then
                      echo; echo ${green}$junk${reset} "junk file being copied -> ${green}${drives[$toDirectory]}/0gram/$i"${reset}
                      cp $junk  "${drives[$toDirectory]}/0gram/$i"
                  fi
              done
              IFS=$SAVEIFS
              ###########
              cd 0Pictures
              if [[ `ls -1 |grep ."jpg" | wc -l` -gt 0 ]]; then
                        SAVEIFS=$IFS
                        IFS=$(echo -en "\n\b")
                        for j in *
                        do
                          mv $j "${drives[$toDirectory]}/0gram/$i/0Pictures"
                          echo ${red}"moving /0gram/0Pictures/$j to ${drives[$toDirectory]}/0gram/$i/0Pictures"${reset}
                      done
                      IFS=$SAVEIFS
                      cd .. && cd ..
              else
              cd .. && cd ..
              fi

              cd $i && cd 0clips
              if [[ `ls -1 |grep ."mp4" | wc -l` -gt 0 ]]; then
                        SAVEIFS=$IFS
                        IFS=$(echo -en "\n\b")
                        for j in *
                        do
                          mv $j "${drives[$toDirectory]}/0gram/"$i"/0clips"
                          echo ${red}"moving $j to ${drives[$toDirectory]}/0gram/"$i"/0clips"${reset}
                      done
                      IFS=$SAVEIFS
                      cd .. && cd ..
              else
              cd .. && cd ..
              fi
        else

          if [[ -d $i ]]; then echo ${blue}'/'$i "Directory copied over -> 0gram" ${reset} && cp -r $i "${drives[$toDirectory]}/0gram"; fi
        fi
      let progesscount+=1;

      done
      IFS=$SAVEIFS
    else
      echo; echo ${red}"Try again: ${reset}no drive choosen ${red}OR${reset} -> destination doesn't exist"
    fi
fi
