vim.g.mapleader = " "
-- no timeout for leader key commands
vim.o.timeout = false -- disabling cause im not fast yet
vim.o.timeoutlen = 300

-- clear highlights
vim.keymap.set('n', '<Esc>', ':noh<CR>')

-- opens the project view
vim.keymap.set("n", "<leader>pv", function()
  -- vim.cmd("w")      -- Save the current file
  vim.cmd("Ex")     -- Open the file explorer
end)

-- reformat the entire file
vim.keymap.set("n", "<leader>=", "gg=G", { desc = "Reformat whole file" })

-- moves selected lines up and down
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", opts)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Increment/decrement numbers
vim.keymap.set('n', '<leader>+', '<C-a>', opts) -- increment
vim.keymap.set('n', '<leader>-', '<C-x>', opts) -- decrement

-- window remaps
vim.keymap.set('n', '<leader>wg', '<C-w>v', opts)      -- split window vertically
vim.keymap.set('n', '<leader>wv', '<C-w>s', opts)      -- split window horizontally
vim.keymap.set('n', '<leader>w=', '<C-w>=', opts)     -- make split windows equal width & height
vim.keymap.set('n', '<leader>w+', ':vertical resize +10<CR>', opts)     -- make split windows equal width & height
vim.keymap.set('n', '<leader>w-', ':vertical resize -10<CR>', opts)     -- make split windows equal width & height
vim.keymap.set('n', '<leader>wx', ':close<CR>', opts) -- close current split window
-- Navigate between splits
vim.keymap.set('n', '<leader>wk', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<leader>wj', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<leader>wh', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<leader>wl', ':wincmd l<CR>', opts)
-- Buffers
vim.keymap.set('n', '<leader>bn', ':bnext', opts)   -- next buffer
vim.keymap.set('n', '<leader>bp', ':bprev', opts) -- prev buffer
-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts)   -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts)     --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts)     --  go to previous tab

-- Automatically center the cursor after certain actions (useful for smooth navigation)
vim.keymap.set("n", "J", "mzJ`z")  -- Join lines while keeping the cursor in place
vim.keymap.set("n", "<C-d>", "<C-d>zz")  -- Scroll down one page and center the cursor
vim.keymap.set("n", "<C-u>", "<C-u>zz")  -- Scroll up one page and center the cursor
vim.keymap.set("n", "n", "nzzzv")  -- Search for the next match and center the screen
vim.keymap.set("n", "N", "Nzzzv")  -- Search for the previous match and center the screen

-- Quick jump to next/previous error in the quickfix list
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")  -- Go to next error in quickfix and center the screen
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")  -- Go to previous error in quickfix and center the screen

-- Copy content to the system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])  -- Copy selected text to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])  -- Copy the entire line to system clipboard

-- Delete content to the black hole register (no effect on clipboard)
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")  -- Delete text without affecting clipboard
vim.keymap.set({ "n", "v" }, "<leader>D", "\"_dd")  -- Delete the line without affecting clipboard 

-- Paste from system clipboard in visual mode (like 'p' and 'P')
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p")  -- Paste after the cursor
vim.keymap.set({ "n", "v" }, "<leader>P", "\"+P")  -- Paste before the cursor
vim.keymap.set('v', 'p', '"_dP', opts) -- Keep last yanked when pasting

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Format the current file with a plugin (useful for code formatting)
vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ bufnr = 0 })  -- Formats the current buffer
end)

-- Search and replace the current word with the same word (useful for quick corrections)
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])  -- Replace the current word globally in the file

-- Make the current file executable (useful for shell scripts, etc.)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })  -- Make the current file executable

-- Start/Stop Vim with Me (collaborative Vim editing plugin)
vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)  -- Start collaborative Vim session
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)  -- Stop collaborative Vim session

-- Reload the current configuration (useful for applying changes)
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")  -- Source the current configuration file to apply changes
end)
vim.keymap.set("n", "<C-s>", ":w<CR>")  -- Save file with Ctrl+S

-- Disable the Q key in normal mode 
vim.keymap.set("n", "Q", "<nop>")  -- Disable 'Q' key in normal mode
