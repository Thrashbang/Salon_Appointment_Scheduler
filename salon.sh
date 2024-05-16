#! /bin/bash

psql --username=freecodecamp --dbname=salon -c "TRUNCATE customers, appointments, services;"
psql --username=freecodecamp --dbname=salon -c "CREATE TABLE customers(customer_id SERIAL PRIMARY KEY);"
psql --username=freecodecamp --dbname=salon -c "CREATE TABLE appointments(appointment_id SERIAL PRIMARY KEY);"
psql --username=freecodecamp --dbname=salon -c "CREATE TABLE services(service_id SERIAL PRIMARY KEY);"
psql --username=freecodecamp --dbname=salon -c "ALTER TABLE appointments ADD COLUMN customer_id INT REFERENCES customers(customer_id);"
psql --username=freecodecamp --dbname=salon -c "ALTER TABLE appointments ADD COLUMN service_id INT REFERENCES services(service_id);"
psql --username=freecodecamp --dbname=salon -c "ALTER TABLE customers ADD COLUMN phone VARCHAR(20) UNIQUE;"
psql --username=freecodecamp --dbname=salon -c "ALTER TABLE customers ADD COLUMN name VARCHAR(25);"
psql --username=freecodecamp --dbname=salon -c "ALTER TABLE services ADD COLUMN name VARCHAR(25);"
psql --username=freecodecamp --dbname=salon -c "ALTER TABLE appointments ADD COLUMN time VARCHAR(5);"
psql --username=freecodecamp --dbname=salon -c "INSERT INTO services(name) VALUES('cut'), ('color'), ('style');"


echo -e "Welcome to My Salon. What service would you like?\n"

readService() {

  PSQL="psql --username=freecodecamp --dbname=salon -c"

  services_list=$($PSQL "SELECT * FROM services;")
  services_count=$($PSQL "SELECT COUNT(service_id) FROM services;")

  echo "$services_list" | while read id pipe service
  do
    if [[ $service == "cut" ]]
    then
      echo -e "$id) "$service""
    elif [[ $service == "color" ]]
    then
      echo -e "$id) "$service""
    elif [[ $service == "style" ]]
    then
      echo -e "$id) "$service""
    fi
  done

  read SERVICE_ID_SELECTED

  if [[ $SERVICE_ID_SELECTED -gt 3 ]]
  then
    echo -e "Service not found. What service would you like?\n"
    readService
  elif [[ $SERVICE_ID_SELECTED -lt 1 ]]
  then
    echo -e "Service not found. What service would you like?\n"
    readService
  else
    echo "What's your phone number?"
    read CUSTOMER_PHONE
    phoneQuery="$($PSQL "SELECT name FROM customers WHERE phone='$CUSOMER_PHONE'")"
    echo $phoneQuery | while IFS=" " read title name rows paren
    do
      if [[ $name == "------" ]]
      then
        echo "Phone number not recognized. What is your name?"
      fi
    done
  fi
 
}

readService

exit
