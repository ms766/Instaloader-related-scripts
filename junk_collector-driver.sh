#!/usr/bin/env bash
#running bash 4
if [[ $1 == '' ]]; then
  exit
fi

echo $1 >> gram-junk_collector-List.txt

while IFS= read -r line; do
  cd && cd "Pictures"  && cd "0gram"
  for i in *
  do
  if [[ $i == $line && $i != '' ]]; then cwd=`pwd`; echo $cwd'/'$i 'matched & removed'; cd $i; cd ..; rm -r $i; fi
  done
done < gram-junk_collector-List.txt
