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
git config --global core.packedGitWindowSize 128m
git config --global core.packedGitLimit 128m
git config --global pack.deltaCacheSize 128m
git config --global pack.packSizeLimit 128m
git config --global pack.windowMemory 128m
git config --global http.postbuffer 5m

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
echo "Installation du script storageChecker..."
cp storageChecker.sh ..
echo
echo "Veuillez créer ce cron manuellement: cd /home/'nom dutilisateur'/www/'nom du site'; storageChecker 'nom du site' >/dev/null 2>&1"
read -n 1 -s -r -p "Presser n'importe quel bouton pour finaliser l'installation"
echo
echo
echo "Installation done"
