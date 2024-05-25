#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -c"

create_customers=$($PSQL "CREATE TABLE customers(customer_id SERIAL PRIMARY KEY);")
create_appointments=$($PSQL "CREATE TABLE appointments(appointment_id SERIAL PRIMARY KEY);")
create_services=$($PSQL "CREATE TABLE services(service_id SERIAL PRIMARY KEY);")
add_foreign_customer_key_to_appointments=$($PSQL "ALTER TABLE appointments ADD COLUMN customer_id INT REFERENCES customers(customer_id);")
add_foreign_service_key_to_appointments=$($PSQL "ALTER TABLE appointments ADD COLUMN service_id INT REFERENCES services(service_id);")
add_phone_to_customers=$($PSQL "ALTER TABLE customers ADD COLUMN phone VARCHAR(20) UNIQUE;")
add_name_to_customers=$($PSQL "ALTER TABLE customers ADD COLUMN name VARCHAR(25);")
add_name_to_services=$($PSQL "ALTER TABLE services ADD COLUMN name VARCHAR(25) UNIQUE;")
add_time_to_appointments=$($PSQL "ALTER TABLE appointments ADD COLUMN time VARCHAR(5);")
insert_into_services=$($PSQL "INSERT INTO services(name) VALUES('cut'), ('color'), ('perm'), ('style'), ('trim');")


echo -e "Welcome to My Salon, how can I help you?\n"

readService() {

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

  read SERVICE_ID_SELECTED

  if [[ $SERVICE_ID_SELECTED -gt 5 ]]
  then
    echo -e "\nI could not find that service. What would you like today?"
    readService
  elif [[ $SERVICE_ID_SELECTED -lt 1 ]]
  then
    echo -e "\nI could not find that service. What would you like today?"
    readService
  else
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE';")

    if [[ -z$phoneQuery ]]
    then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      ADD_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME');")
    fi

    SERVICE=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED;")

    echo $SERVICE | while read title hyphens name num close
    do
      echo -e "\nWhat time would you like your $name, $CUSTOMER_NAME?"
    done
    read SERVICE_TIME

    echo $SERVICE | while read title hyphens name num close
    do
      echo -e "\nI have put you down for a $name at $SERVICE_TIME, $CUSTOMER_NAME."
    done
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    echo $CUSTOMER_ID | while read title hyphens id num close
    do
      SCHEDULE_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($id, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
    done
  fi
 
}

echo -e "\n~~~~~ MY SALON ~~~~~\n"

readService

exit
