## Tips
1. if a plugin is not working as expected use `:checkhealth PLUGIN` e.g. `:checkhealth telescope`
2. if installing a new plugin you can use cmd `Lazy sync` to sync without restarting nvim

## Useful Commands to Navigate
1. <leader>pv - project view
2. <C-w>hjkl - selects the window to the left/bottom/up/right

## Pre-Reqs
For some packages you will need pre-reqs installed on the system
```
brew install lua ripgrep tree-sitter

wget https://luarocks.org/releases/luarocks-3.11.1.tar.gz
tar zxpf luarocks-3.11.1.tar.gz
cd luarocks-3.11.1
./configure && make && sudo make install
sudo luarocks install luasocket
```