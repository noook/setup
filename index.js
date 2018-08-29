const { execSync } = require('child_process');
const inquirer = require('inquirer');

const casks = [
  {
    name: 'Firefox Developer Edition',
    cask: 'firefox-developer-edition'
  },
  {
    name: 'VS Code',
    cask: 'visual-studio-code'
  },
  {
    name: 'Discord',
    cask: 'discord'
  },
  {
    name: 'Spotify',
    cask: 'spotify'
  },
  {
    name: 'Google Chrome',
    cask: 'google-chrome'
  },
  {
    name: 'Hyper',
    cask: 'hyper'
  }
];


inquirer
  .prompt({
      type: 'checkbox',
      name: 'casks',
      message: 'Select applications you want to install with space and press enter',
      choices: casks.map(cask => cask.name),
      default: ['Firefox Developer Edition', 'VS Code', 'Google Chrome', 'Hyper', 'Discord']
    }
  )
  .then(answers => {
    const selected = [];
    answers.casks.forEach(cask => selected.push(casks.find(item => cask === item.name)));
    for (let i in selected) {
      console.log(`\u{1b}[1;35mInstalling ${selected[i].name}...\u{1b}[0m\n`)
      console.log(execSync(`brew cask install ${selected[i].cask}`, {
        encoding: 'utf-8'
      }));
      console.log(`${selected[i].name} installed ✅ \n`);
    }
  });