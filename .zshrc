# Check if we're running in VSCode's integrated terminal
isVSCode=false
if [ "$TERM_PROGRAM" = "vscode" ]; then
  isVSCode=true
fi

# common shortcuts
alias nvimcfg='cd ~/.config && nvim .'
alias zshrc='nvim ~/.zshrc'
alias srcz='source ~/.zshrc'
alias ll="ls -la --color=auto"
alias fcd='cd "$(dirname "$(fzf)")"'
alias dsk='cd ~/Desktop'
alias cfg='cd ~/.config'

# Use Neovim as default editor
# export EDITOR="nvim" stops wezterm from using vim in cli
# export VISUAL="nvim" stops wezterm from using vim in cli

# themes, these may not work yet still need to test
export TMUX_THEME="nord"
export NVIM_THEME="nord"
export STARSHIP_THEME="nord"
export WEZTERM_THEME="nord"
 
# git shortcuts
alias ga="git add ."
alias gs="git status"
alias gp="git push"
alias gb="git branch"
alias gl="git log --oneline"
function gc() {
  if [ "$#" -eq 1 ]; then
    git commit -m "$1"
  else
    echo "Error: You must provide exactly one commit message"
  fi
}

# starship prompt init and zsh auto complete
if [ "$isVSCode" = true ]; then
  export STARSHIP_CONFIG="$HOME/dotfiles/starship/vscode-starship.toml"
else
  export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
fi
eval "$(starship init zsh)"
export STARSHIP_COMMAND_TIMEOUT=1000
if [ "$isVSCode" = false ]; then
  starship config palette $STARSHIP_THEME
fi

ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$(brew --prefix)/share/zsh-syntax-highlighting/highlighters
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Always work in a tmux session if Tmux is installed except for vscode
if [ "$isVSCode" = false ]; then
  if which tmux 2>&1 >/dev/null; then
    if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
        # Use "main" session for regular terminals
        tmux attach -t main || tmux new -s main; exit
    fi
  fi
fi