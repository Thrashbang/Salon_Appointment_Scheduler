!#/bin/bash

  echo "$services_list" | while read id pipe service
  do
    if [[ $service == "cut" ]]
    then
      echo -e "$id) "$service""
    elif [[ $service == "color" ]]
    then
      echo -e "$id) "$service""
    elif [[ $service == "perm" ]]
    then
      echo -e "$id) "$service""
    elif [[ $service == "style" ]]
    then
      echo -e "$id) "$service""
      elif [[ $service == "trim" ]]
    then
      echo -e "$id) "$service""
    fi
  done
