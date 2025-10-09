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
alias dsk='cd ~/Desktop'
alias cfg='cd ~/.config'

# shortcuts for specific technologies, e.g. k8, bazel, go
alias k=kubectl
alias got="go test ./..."
function gob() {
  name="$1"
  shift
  go build -o "$name" "$@"
}
alias bzltest="bazel test ... --verbose_test_summary=true --verbose_failures=true --test_output=all"
alias bzlbuild="bazel build ..."

# Find functions with fzf
# ff - find file and cd to its directory (current dir)
function ff() {
  local file
  file=$(eval "command fd --type f $FD_OPTIONS ." | fzf --exact --no-sort --keep-right)
  if [[ -n "$file" ]]; then
    cd "$(dirname "$file")" || return
  fi
}

# fd - find directory and cd into it (current dir) - NOTE: overrides fd binary but we use it via command fd
function fd() {
  local dir
  dir=$(eval "command fd --type d $FD_OPTIONS ." | fzf --exact --no-sort --keep-right)
  if [[ -n "$dir" ]]; then
    cd "$dir" || return
  fi
}

# ffh - find file and cd to its directory (home dir)
function ffh() {
  local file
  file=$(eval "command fd --type f $FD_OPTIONS . ~" | fzf --exact --no-sort --keep-right)
  if [[ -n "$file" ]]; then
    cd "$(dirname "$file")" || return
  fi
}

# fdh - find directory and cd into it (home dir)
function fdh() {
  local dir
  dir=$(eval "command fd --type d $FD_OPTIONS . ~" | fzf --exact --no-sort --keep-right)
  if [[ -n "$dir" ]]; then
    cd "$dir" || return
  fi
}

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
alias gpush='git push origin $(git branch --show-current)'
function gc() {
  if [ "$#" -eq 1 ]; then
    git commit -m "$1"
  else
    echo "Error: You must provide exactly one commit message"
  fi
}
alias gca="git commit --amend"

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

# fd configuration - exclude noisy directories globally
export FD_OPTIONS="--hidden --follow --exclude .git --exclude node_modules --exclude 'bazel-*' --exclude build --exclude dist --exclude target --exclude .next --exclude .cache --exclude .idea --exclude .vscode --exclude coverage --exclude __pycache__ --exclude .DS_Store --exclude .pytest_cache --exclude .mypy_cache --exclude .ruff_cache --exclude .tox --exclude venv --exclude .venv --exclude site-packages --exclude .gradle --exclude .m2 --exclude .ivy2 --exclude pkg/mod --exclude vendor --exclude .terraform --exclude .svn --exclude .hg --exclude .npm --exclude .yarn --exclude .pnpm-store --exclude bower_components --exclude out --exclude tmp --exclude temp --exclude .turbo --exclude .nuxt --exclude .output --exclude .vercel --exclude .netlify --exclude .aws-sam --exclude .serverless"

# fzf configuration - use fd as the default command
export FZF_DEFAULT_COMMAND="fd --type f $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

# fzf key bindings (Ctrl+R for history search, etc.)
source <(fzf --zsh)

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
