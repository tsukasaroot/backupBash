REMOTE=$1

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

if [ -z $1 ]
then
  echo -e "${RED}remote url manquante dans l'argument CLI${NC}"
  exit -1
fi

if [ ! -f ~/.ssh/id_rsa ]
then
  ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
  echo
fi
cat ~/.ssh/id_rsa.pub
echo
echo -e "${YELLOW}Copier cette clé publique avant de continuer dans https://fructiweb.synology.me:3000/user/settings/ssh${NC}"
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

touch .gitignore
echo -e "wp-content/et-cache\n*php_errorlog*\n*wf_logs" > .gitignore

git remote add origin $1
echo
echo -e "${CYAN}Adding files to tracking${NC}"
echo
git add *
echo
echo -e "${CYAN}Commiting added files${NC}"
echo
git commit -m "initial commit"
echo
echo -e "${CYAN}Pushing commit${NC}"
echo
git push -f -u origin master
echo
echo -e "${CYAN}Installation du script storageChecker...${NC}"
cp ../backupBash/storageChecker.sh ..
echo
echo -e "${CYAN}Veuillez créer ce cron manuellement:${NC}"
echo "cd /home/nom_dutilisateur/www/nom_du_site; ./storageChecker nom_du_site >/dev/null 2>&1"
read -n 1 -s -r -p "Presser n'importe quel bouton pour finaliser l'installation"
echo
echo
echo -e "${GREEN}Installation done${NC}"
