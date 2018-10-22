#!/bin/zsh

PURPLE='\033[1;35m'
NC='\033[0m'

source ~/.zshrc

echo "\n${PURPLE}Installing Node and nvm${NC}\n"
brew install node nvm

  . "/usr/local/opt/nvm/nvm.sh"

echo "export NVM_DIR=\"$HOME/.nvm\"" >> ~/.zshrc
echo ". \"/usr/local/opt/nvm/nvm.sh\"" >> ~/.zshrc

~/.scripts/nvm install 10
~/.scripts/nvm alias default 10
~/.scripts/nvm use 10

echo "\n${PURPLE}Checking for node version:${NC}\n"
MIN_VERSION="8.5.0"
VERSIONS=($MIN_VERSION)
NODE_V=$(echo $(node -v | sed -n -E 's/v(.+)/\1/p'))
VERSIONS+=($NODE_V)
IFS=$'\n' VERSIONS=($(sort -V <<<"${VERSIONS[*]}"))
unset IFS

installation() {
  echo "\n${PURPLE}Proceeding to installation${NC}\n"
  FOLDER_NAME=$RANDOM$RANDOM
  echo "Creating temporary installation folder $FOLDER_NAME"
  mkdir ~/Documents/$FOLDER_NAME
  cd ~/Documents/$FOLDER_NAME
  curl -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/neilrichter/setup/master/index.js > index.js
  npm install inquirer
  node index.js
  rm -fr ~/Documents/$FOLDER_NAME
  rm ~/script.sh
  rm ~/next.sh
}

if [ ${VERSIONS[1]} == $MIN_VERSION ];
then
  installation
fi
