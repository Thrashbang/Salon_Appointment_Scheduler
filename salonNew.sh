!#/bin/bash

readService() {

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

  read SERVICE_ID

  if [[ $SERVICE_ID -gt 3 ]]
  then
    echo -e "\nI could not find that service. What would you like today?"
    readService
  elif [[ $SERVICE_ID -lt 1 ]]
  then
    echo -e "\nI could not find that service. What would you like today?"
    readService
  fi

}
