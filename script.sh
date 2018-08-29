 #!/bin/bash

PURPLE='\033[1;35m'
NC='\033[0m'

# Brew Installation
echo "\n${PURPLE}Installing Brew${NC}\n"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

echo "\n${PURPLE}Updating Brew${NC}\n"
brew update

git -C "/usr/local/Homebrew" remote add origin https://github.com/Homebrew/brew.git
git -C "$(brew --repo homebrew/core)" fetch --unshallow

echo "\n${PURPLE}Installing Apple Command Line Tools${NC}\n"
xcode-select --install

echo "\n${PURPLE}Installing zsh${NC}\n"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "\n${PURPLE}Setting zsh as default shell${NC}\n"
chsh -s /bin/zsh

echo "\n${PURPLE}Setting up One Dark theme as default theme${NC}\n"
curl https://raw.githubusercontent.com/benniemosher/the-one-theme/master/zsh/TheOne.zsh-theme -o ~/.oh-my-zsh/themes/TheOne.zsh-theme

mkdir ~/scripts/
if [[ $PATH != *"$HOME/scripts"* ]];then
    echo "PATH=$PATH:\"$HOME/.scripts\"" >> ~/.zshrc
fi
which nvm > ~/.scripts/nvm

echo "Enables zsh to read utf-8 content"
sed -i.bak -E 's/#\ export\ LANG=(.+)/export\ LANG=fr.UTF-8/' ~/.zshrc
echo "One Dark Theme for zsh"
sed -i.bak -E 's/ZSH_THEME="(.+)"/ZSH_THEME="TheOne"/' ~/.zshrc

rm ~/.zshrc.bak