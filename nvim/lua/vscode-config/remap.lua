vim.g.mapleader = " "
-- no timeout for leader key commands
vim.o.timeout = false
vim.o.timeoutlen = 300

-- clear highlights
vim.keymap.set('n', '<Esc>', ':noh<CR>')

-- VSCode-specific commands
vim.keymap.set('n', '<leader>pv', "<Cmd>call VSCodeNotify('workbench.view.explorer')<CR>")

-- reformat the entire file
vim.keymap.set("n", "<leader>=", "<Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>", { desc = "Reformat whole file" })

-- moves selected lines up and down (using VSCode commands)
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<A-j>", "<Cmd>call VSCodeNotify('editor.action.moveLinesDownAction')<CR>", opts)
vim.keymap.set("n", "<A-k>", "<Cmd>call VSCodeNotify('editor.action.moveLinesUpAction')<CR>", opts)
vim.keymap.set("v", "<A-j>", "<Cmd>call VSCodeNotify('editor.action.moveLinesDownAction')<CR>", opts)
vim.keymap.set("v", "<A-k>", "<Cmd>call VSCodeNotify('editor.action.moveLinesUpAction')<CR>", opts)
vim.keymap.set("i", "<A-j>", "<Cmd>call VSCodeNotify('editor.action.moveLinesDownAction')<CR>", opts)
vim.keymap.set("i", "<A-k>", "<Cmd>call VSCodeNotify('editor.action.moveLinesUpAction')<CR>", opts)

-- Increment/decrement numbers
vim.keymap.set('n', '<leader>+', '<C-a>', opts) -- increment
vim.keymap.set('n', '<leader>-', '<C-x>', opts) -- decrement

-- window remaps (using VSCode commands)
vim.keymap.set('n', '<leader>wg', "<Cmd>call VSCodeNotify('workbench.action.splitEditorRight')<CR>", opts)
vim.keymap.set('n', '<leader>wv', "<Cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>", opts)
vim.keymap.set('n', '<leader>w=', "<Cmd>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>", opts)
vim.keymap.set('n', '<leader>wx', "<Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>", opts)

-- Navigate between splits using Alt+hjkl (using VSCode commands)
vim.keymap.set('n', '<A-h>', "<Cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>", opts)
vim.keymap.set('n', '<A-j>', "<Cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>", opts)
vim.keymap.set('n', '<A-k>', "<Cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>", opts)
vim.keymap.set('n', '<A-l>', "<Cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>", opts)

-- Buffers/Tabs (using VSCode commands)
vim.keymap.set('n', '<leader>bn', "<Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>", opts)
vim.keymap.set('n', '<leader>bp', "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>", opts)
vim.keymap.set('n', '<leader>to', "<Cmd>call VSCodeNotify('workbench.action.files.newUntitledFile')<CR>", opts)
vim.keymap.set('n', '<leader>tx', "<Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>", opts)
vim.keymap.set('n', '<leader>tn', "<Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>", opts)
vim.keymap.set('n', '<leader>tp', "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>", opts)

-- Automatically center the cursor after certain actions
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy content to the system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete content to the black hole register
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")
vim.keymap.set({ "n", "v" }, "<leader>D", "\"_dd")

-- Paste from system clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p")
vim.keymap.set({ "n", "v" }, "<leader>P", "\"+P")
vim.keymap.set('v', 'p', '"_dP', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Format the current file (using VSCode command)
vim.keymap.set("n", "<leader>fd", "<Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>")

-- Search and replace the current word (using VSCode command)
vim.keymap.set("n", "<leader>rw", "<Cmd>call VSCodeNotify('editor.action.startFindReplaceAction')<CR>")

-- Save file with Ctrl+S (using VSCode command)
vim.keymap.set("n", "<C-s>", "<Cmd>call VSCodeNotify('workbench.action.files.save')<CR>")

-- Disable the Q key in normal mode 
vim.keymap.set("n", "Q", "<nop>")
