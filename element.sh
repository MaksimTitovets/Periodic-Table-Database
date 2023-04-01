#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --tuples-only -c"

if [[ $1 ]]
then
  if [[ ! $1  =~ ^[0-9]+$ ]]
  then
    ELEMENT_FIND=$($PSQL "SELECT * FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$1' OR name='$1';")
  else
    ELEMENT_FIND=$($PSQL "SELECT * FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$1;")
  fi
  
  if [[ -z $ELEMENT_FIND ]]
  then
    echo "I could not find that element in the database."
  else
    echo "$ELEMENT_FIND" | while read TYPE_ID BAR ATOMIC_NUMBER BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR SYMBOL BAR NAME BAR TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
    done
  fi
else
  echo "Please provide an element as an argument."
fi
