REMOTE=$1

ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
cd ../public_html
git init
git config --global core.preloadIndex false
git remote add origin $1
git add *
git commit -m "initial commit"
git push -u origin master
