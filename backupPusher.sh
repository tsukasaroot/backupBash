USERNAME=$1
DATABASE=$2
PASSWORD=$3
WEBSITE=$4

mysqldump -u$USERNAME -p$PASSWORD --all-databases > ../$WEBSITE.sql
cd ../public_html
git add *
git commit -m "Automatic backup commit"
git push -u origin master
