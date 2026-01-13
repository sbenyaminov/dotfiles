# ---------------- OS DETECTION ----------------
OS_TYPE="$(uname -s)"

isVSCode=false
[[ "$TERM_PROGRAM" == "vscode" ]] && isVSCode=true

# ---------------- COMMON ALIASES ----------------
alias nvimcfg='cd ~/.config && nvim .'
alias zshrc='nvim ~/.zshrc'
alias srcz='source ~/.zshrc'
alias ll="ls -la --color=auto"
alias dsk='cd ~/Desktop'
alias cfg='cd ~/.config'

alias claudeyolo="claude --dangerously-skip-permissions"
alias k=kubectl
alias got="go test ./..."
alias bzltest="bazel test ... --verbose_test_summary=true --verbose_failures=true --test_output=all"
alias bzlbuild="bazel build ..."

function gob() { name="$1"; shift; go build -o "$name" "$@"; }

# ---------------- FZF + FD ----------------
function ff() {
  local file
  file=$(command fd --type f ${=FD_OPTIONS} . | fzf --exact --no-sort --keep-right)
  [[ -n "$file" ]] && cd "$(dirname "$file")"
}

function fd() {
  local dir
  dir=$(command fd --type d ${=FD_OPTIONS} . | fzf --exact --no-sort --keep-right)
  [[ -n "$dir" ]] && cd "$dir"
}

function ffh() {
  local file
  file=$(command fd --type f ${=FD_OPTIONS} . ~ | fzf --exact --no-sort --keep-right)
  [[ -n "$file" ]] && cd "$(dirname "$file")"
}

function fdh() {
  local dir
  dir=$(command fd --type d ${=FD_OPTIONS} . ~ | fzf --exact --no-sort --keep-right)
  [[ -n "$dir" ]] && cd "$dir"
}

# ---------------- THEMES ----------------
export TMUX_THEME="nord"
export NVIM_THEME="nord"
export STARSHIP_THEME="nord"
export WEZTERM_THEME="nord"

# ---------------- GIT ----------------
alias lg="lazygit"
alias ga="git add -A"
alias gs="git status"
alias gpull="git pull"
alias gb="git branch"
alias gl="git log --oneline -n 50"
alias gcm="git checkout main 2>/dev/null || git checkout master"
alias gpush='git push origin $(git branch --show-current)'
alias gca="git commit --amend"

function gc() { [[ "$#" -eq 1 ]] && git commit -m "$1" || echo "commit msg required"; }

function gitcompare() {
  git log --oneline "$1..$2" -- "$3"
}

# ---------------- SSH AGENT FIX ----------------
if [[ "$OS_TYPE" == "Darwin" ]]; then
  export SSH_AUTH_SOCK=$(launchctl getenv SSH_AUTH_SOCK)
elif [[ "$OS_TYPE" == "Linux" ]]; then
  export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
fi

# ---------------- STARSHIP ----------------
if command -v starship &>/dev/null; then
  if $isVSCode; then
    export STARSHIP_CONFIG="$HOME/dotfiles/starship/vscode-starship.toml"
  else
    export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
  fi
  eval "$(starship init zsh)"
fi

# ---------------- ZSH PLUGINS ----------------
if command -v brew &>/dev/null; then
  ZSH_PREFIX=$(brew --prefix)

  [[ -f "$ZSH_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] &&
    source "$ZSH_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

  [[ -f "$ZSH_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] &&
    source "$ZSH_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# ---------------- FD + FZF CONFIG ----------------
export FD_OPTIONS="--hidden --follow --exclude .git --exclude node_modules --exclude dist --exclude build --exclude target --exclude .next --exclude .cache --exclude .idea --exclude .vscode"

export FZF_DEFAULT_COMMAND="fd --type f $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

command -v fzf &>/dev/null && source <(fzf --zsh)

# ---------------- PYENV ----------------
if command -v pyenv &>/dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
fi

# ---------------- NVM ----------------
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
