REMOTE=$1

if [ -z $1 ]
then
  echo "remote url manquante dans l'argument CLI"
  return -1
fi

ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
echo
cat ~/.ssh/id_rsa.pub
echo
echo "Copier cette clé publique avant de continuer dans https://fructiweb.synology.me:3000/user/settings/ssh"
echo
read -n 1 -s -r -p "Presser n'importe quel bouton si la clé est correctement copié"
echo
cd ../public_html
git init
git config --global core.preloadIndex false
git remote add origin $1
echo
echo "Adding files to tracking"
echo
git add *
echo
echo "Commiting added files"
echo
git commit -m "initial commit"
echo
echo "Pushing commit"
echo
git push -u origin master
echo
echo "Installation done"
