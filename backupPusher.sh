#!/bin/sh

if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
  mysqldump -u -p --al-databases > $PATH/$WEBSITE.sql
  cd $PATH
  git commit -am "Automatic backup commit"
  git push
fi
