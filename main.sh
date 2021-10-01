#!/usr/bin/env bash
#running bash 4
source .env
reset=$(tput sgr0); black=$(tput setaf 0);blue=$(tput setaf 33);
cyan=$(tput setaf 37);green=$(tput setaf 64);orange=$(tput setaf 166);
purple=$(tput setaf 125);red=$(tput setaf 124);violet=$(tput setaf 61);
white=$(tput setaf 15);yellow=$(tput setaf 136);

#################################
cd && cd "Pictures" && cd "0gram";
#################################
if [[ $1 == '' ]]; then
  	echo
  	echo "${orange}Error, Enter a vaild instagram profile to download"
  	echo
else

  #login in
  if [ $1 = 'login' ]; then
    instaloader "--login=$gram_username" --stories $2
  else
    instaloader  $1
  fi

  if [ ! -d $1 -a $# -lt 2 ] || [ ! -d $2 ]; then

    echo "Dir does not exist && script exited" && exit
  elif [[ $2 != "" ]]; then
    set $2
  fi

  echo $1
  cd $1


  if [ ! -d "0clips" -a  "0Pictures" ]; then
      mkdir "0clips"
      mkdir "0Pictures"
  fi

  list=`ls`
  dirCount=`ls . | wc -l`
  if [ $dirCount -eq 0 ]; then
    date > ${1}fileRecord.txt
  fi
  for word in $list
  do
    if [ $word != "${1}fileRecord.txt" -a $word != "${1}fileRecordSorted.txt" -a ! -d $word ]; then
        echo $word >> ${1}fileRecord.txt
    else
        touch "${1}fileRecord.txt"
    fi
  done
  if [ -f "${1}fileRecord.txt" ]; then
    sort ${1}fileRecord.txt | uniq > ${1}fileRecordSorted.txt
  fi
  #printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' - >> ${1}fileRecord.txt
  mv ${1}fileRecordSorted.txt ..
  find . -type f -name "*.txt" -delete
  find . -type f -name "id" -delete
  find . -type f -name "*.xz" -delete
  cd ..

  if [ -d $1 -a -f "${1}fileRecordSorted.txt" ]; then
    mv "${1}fileRecordSorted.txt" $1
  fi

  cd "$1"
  find ./ -maxdepth 1 -name "*.jpg" -exec mv -vn '{}' "./0Pictures" \;
  echo
  find ./ -maxdepth 1 -name '*.mp4' -exec mv -vn '{}' "./0clips" \;

  while IFS= read -r line
  do
    touch $line
  done < "${1}fileRecordSorted.txt"

  echo
  echo ${green}"$1 Download Complete"${reset}
  find "./0Pictures" -size 0 -print0 | xargs -0 -I rm
  find "./0clips" -size 0 -print0 | xargs -0 -I rm

  #move folder with 1 pic in them to pirvate folder #<--- go over
  pic_count=`ls | grep -c *.jpg`
  if [[ $pic_count == 1 ]]; then
     cd ..
     if [ -d '1gram_private' ]; then
        mv "$1" "1gram_private"
    else
      mkdir "1gram_private";
      mv "$1" "1gram_private";
    fi
  fi
fi
