#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n\n~~~~~~ Fresh Cuts & Dreds ~~~~~~~\n"
echo What can we do for you today?
MENU=$($PSQL "SELECT name FROM services")

echo $MENU | while read SERVICE_1 SERVICE_2 SERVICE_3
do
echo -e "\n1) $SERVICE_1 \n2) $SERVICE_2 \n3) $SERVICE_3"
done 