## Context
Dotfiles for 
- terminal using wezterm with zsh, starship, and tmux heavily inspired by https://github.com/hendrikmi/dotfiles
- install for nvim heavily inspired by https://github.com/ThePrimeagen/.dotfiles

## Dev Setup
```
# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install basic terminal commands
- brew install wget curl fd fzf

# install languages and vim
- brew install node nvm python pyenv java vim neovim 

# install terminal
- brew install git zsh tmux starship zsh-syntax-highlighting zsh-autosuggestions
- brew install --cask wezterm

# Install GUI applications
- brew install --cask visual-studio-code
- brew install --cask docker
- brew install --cask rectangle # Window management
```


# Pull the repo into a new directory
```
git clone repo in home directory ~

# symlink to ~/.config for system use
mkdir -p ~/.config
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/tmux ~/.config/tmux
ln -s ~/dotfiles/wezterm ~/.config/wezterm
ln -s ~/dotfiles/starship ~/.config/starship

# source dotfiles zshrc in your ~/.zshrc or use ~/dotfiles/.zshrc as your main one via symlink
source ~/dotfiles/.zshrc
ln -s ~/dotfiles/.zshrc ~
```
