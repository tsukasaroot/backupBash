if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
  /bin/mysqldump -u$USERNAME -p$PASSWORD --all-databases > $PATH/$WEBSITE.sql
  cd $PATH
  /bin/git commit -am "Automatic backup commit"
  /bin/git push
fi