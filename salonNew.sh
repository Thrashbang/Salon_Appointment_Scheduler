!#/bin/bash

echo $(PSQL --username=freecodecamp --dbname=salon -c "SELECT * FROM services") | while read id pipe service
do
  if [[ $service == "Haircut" ]]
  then
    echo -e "$id) "$service""
  elif [[ $service == "Hair Coloring" ]]
  then
    echo -e "$id) "$service""
  elif [[ $service == "Trim" ]]
  then
    echo -e "$id) "$service""
  fi
done

read $
