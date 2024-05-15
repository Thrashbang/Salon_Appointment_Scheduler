#! /bin/bash

psql --username=freecodecamp --dbname=salon -c "CREATE TABLE customers(customer_id SERIAL PRIMARY KEY);"
psql --username=freecodecamp --dbname=salon -c "CREATE TABLE appointments(appointment_id SERIAL PRIMARY KEY);"
psql --username=freecodecamp --dbname=salon -c "CREATE TABLE services(service_id SERIAL PRIMARY KEY);"

psql --username=freecodecamp --dbname=salon -c "ALTER TABLE appointments ADD COLUMN customer_id INT REFERENCES customers(customer_id);"
psql --username=freecodecamp --dbname=salon -c "ALTER TABLE appointments ADD COLUMN service_id INT REFERENCES services(service_id);"
psql --username=freecodecamp --dbname=salon -c "ALTER TABLE customers ADD COLUMN phone VARCHAR(20) UNIQUE;"
psql --username=freecodecamp --dbname=salon -c "ALTER TABLE customers ADD COLUMN name VARCHAR(25);"
psql --username=freecodecamp --dbname=salon -c "ALTER TABLE services ADD COLUMN name VARCHAR(25);"
psql --username=freecodecamp --dbname=salon -c "ALTER TABLE appointments ADD COLUMN time VARCHAR(5);"
