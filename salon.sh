#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n\n~~~~~~ Fresh Cuts & Dreds ~~~~~~~\n"

MENU() {
  if [[ $1 ]]
  then 
    echo -e "\n$1"
  fi
echo What can we do for you today?


echo -e "\n1) Cut  \n2) Line \n3) Dreds"
 
read SERVICE_ID_SELECTED
case $SERVICE_ID_SELECTED in
1)  MAIN_APP;;
2)  MAIN_APP;;
3)  MAIN_APP;;
*) MENU "Please enter a valid number."
esac
}

MAIN_APP() {
SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
echo You chose $SERVICE_NAME 

  echo What is your phone number? 
  read CUSTOMER_PHONE
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'") 
  if [[ -z $CUSTOMER_ID ]] 
  then
  echo What is your name? 
  read CUSTOMER_NAME
  CREATE_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'") 
  echo New Customer 🥳 Welcome $CUSTOMER_NAME!
  else 
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE customer_id =$CUSTOMER_ID")
  echo Hello $CUSTOMER_NAME
  fi
 
  echo What time would you like your $SERVICE_NAME? 
  read SERVICE_TIME

  APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  if [[ $APPOINTMENT_RESULT = "INSERT 0 1" ]]
  then 
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  EXIT
  else
  echo Hold up snaFu
  fi
}
 
EXIT() {
  echo See you soon
  exit
}
MENU

