# Tmux Cheatsheet

## Essential Shortcuts

- Prefix: `CTRL + a`
- Create new tmux window: `Prefix + c`
- Kill tmux pane: `Prefix + x`
- Navigate to window: `Prefix + number`
- Cycle through window: `Prefix + n/p`
- See all windows: `Prefix + w`
- Rename window: `Prefix + ,`
- Rename session: `Prefix + $`
- Explore sessions: `Prefix + s`
- Save sessions: `Prefix + CTRL + s`
- Restore session (after computer restart): `Prefix + CTRL + r`
- Install plugins: `Prefix + I`
- Hozizontal / Vertical split: `Prefix + g/v`
- Move between splits: `Prefix + h/j/k/l`
- Resize splits: `Prefix + arrows left/right/up/down`

## Useful Snippets

Add this to you `.zshrc` to always work in a Tmux session:

```shell
# Always work in a tmux session if Tmux is installed
if which tmux 2>&1 >/dev/null; then
  if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
    tmux attach -t default || tmux new -s default; exit
  fi
fi
```

## Key Commands

Start a new session

```shell
tmux new -s NewSession
```

Exit session

```shell
tmux detach
```

List sessions

```shell
tmux ls
```

Go back into session

```shell
tmux attach -t NewSession
```

Show all available options

```shell
tmux show-options -g
```

Show all available shortcuts

```shell
tmux list-keys
```

Show all available commands

```shell
tmux list-commands
```

Start fresh

```shell
tmux kill-server && rm -rf /tmp/tmux-*
```

Enable plugins

```shell
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
