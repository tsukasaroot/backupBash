#!/bin/sh

if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
  #mysqldump -u root --all-databases > $WEBSITE.sql
  mysqldump -u -p --al-databases > $WEBSITE.sql
fi
