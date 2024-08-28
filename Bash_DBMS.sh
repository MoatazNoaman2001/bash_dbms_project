#!/bin/bash
clear

cd "$(dirname "$BASH_SOURCE")" || exit

#enable extended regex
shopt -s extglob
PS3="**MAIN MENU** choose your option or press Enter to show options again:  "
select task in createDB.sh listDB.sh connectDB.sh dropDB.sh exit
do
  PS3="**MAIN MENU** choose your option or press enter to show options again:  "
  if [[ "$REPLY" = 5 || "$REPLY" = "exit" ]] ; then
    exit
  elif [[ "$REPLY" =~ ^[1-4]$ ]] ; then
      if [[ -f "./$task" && -x "./$task" ]]; then
        ./$task
      else
        echo "Script './$task' not found or not executable"
      fi
  else
    echo "Invalid option"
  fi
done
