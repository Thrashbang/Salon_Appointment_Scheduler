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

readPhone() {

  echo -e "\nWhat's your phone number?"

  read PHONE_NUMBER

  echo $(PSQL --username=freecodecamp --dbname=salon -c "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'") | while IFS=" " read title name number parenthesis
  do
    if [[ "$name" == "------" ]]
    then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read $CUSTOMER_NAME
      $(PSQL --username=freecodecamp --dbname=salon -c "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    fi
  done

}
