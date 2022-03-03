#!/bin/bash

file=""
cthreads=""
duration=""
while getopts 'f:c:d:' OPTION; do
  case "$OPTION" in
    f)
      file="$OPTARG"
      ;;
    c)
      cthreads="$OPTARG"
      ;;
    d)
      duration="$OPTARG"
      ;;
  esac
done

if [ -z "$file" ]; then
  file=urls.txt
fi

if [ -z "$cthreads" ]; then
  cthreads=300
fi

if [ -z "$duration" ]; then
  duration=1h
fi


IFS=$'\n' read -d '' -r -a lines < $file

for i in "${lines[@]}"
do
   echo "firing into $i"
   export URL=$i
   docker run -d --rm alpine/bombardier -c $cthreads -d $duration -l $URL
done

