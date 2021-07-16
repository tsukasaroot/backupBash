if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
  mysqldump -u$USERNAME -p$PASSWORD --all-databases > $PATH/$WEBSITE/public_html/$WEBSITE.sql
  cd $PATH/$WEBSITE/public_html
  git commit -am "Automatic backup commit"
  git push
fi
