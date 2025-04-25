-- TODO
-- 2. scripts / surround
-- 3. multi cursor

-- Load the vscode module
local vscode = require('vscode')
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
-- no timeout for leader key commands
vim.o.timeout = true
vim.o.timeoutlen = 300

-- clear highlights
vim.keymap.set('n', '<Esc>', ':noh<CR>')

vim.keymap.set("n", "u", function() vscode.call('undo') end)

vim.keymap.set('n', '<leader>e', function() vscode.call('workbench.action.toggleSidebarVisibility') end, opts)
vim.keymap.set('n', '<leader>t', function() vscode.call('workbench.action.togglePanel') end, opts)

-- reformat the entire file
vim.keymap.set("n", "<leader>=", function() vscode.call('editor.action.formatDocument') end)

-- Move selected line(s) up/down in visual mode
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", opts)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Increment/decrement numbers
vim.keymap.set('n', '<leader>+', '<C-a>', opts) -- increment
vim.keymap.set('n', '<leader>-', '<C-x>', opts) -- decrement

-- window remaps (using VSCode commands)
vim.keymap.set('n', '<leader>wg', function() vscode.call('workbench.action.splitEditorRight') end, opts)
vim.keymap.set('n', '<leader>wv', function() vscode.call('workbench.action.splitEditorDown') end, opts)
vim.keymap.set('n', '<leader>w=', function() vscode.call('workbench.action.evenEditorWidths') end, opts)
vim.keymap.set('n', '<leader>wx', function() vscode.call('workbench.action.closeActiveEditor') end, opts)

-- Automatically center the cursor after certain actions
vim.keymap.set("n", "J", "mzJ`z")
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

-- Disable the Q key in normal mode
vim.keymap.set("n", "Q", "<nop>")

-- Telescope equivalent commands
-- Find files
vim.keymap.set('n', '<leader>ff', function() vscode.call('workbench.action.quickOpen') end, { desc = 'Find Files' })
-- Fuzzy search (live grep)
vim.keymap.set('n', '<leader>ss', function() vscode.call('workbench.action.findInFiles') end,
    { desc = 'Search in Files' })
-- Diagnostics
vim.keymap.set('n', '<leader>sd', function() vscode.call('workbench.actions.view.problems') end,
    { desc = 'Show Diagnostics' })
-- Recent files
vim.keymap.set('n', '<leader>rr', function() vscode.call('workbench.action.openRecent') end, { desc = 'Recent Files' })
-- Git files
vim.keymap.set('n', '<leader>gg', function() vscode.call('workbench.view.scm') end, { desc = 'Git Files' })
-- Buffers
vim.keymap.set('n', '<leader>bb', function() vscode.call('workbench.action.showAllEditorsByMostRecentlyUsed') end,
    { desc = 'Show Buffers' })
-- Help tags
vim.keymap.set('n', '<leader>hh', function() vscode.call('workbench.action.openDocumentationUrl') end,
    { desc = 'Help Documentation' })
-- Search current word
vim.keymap.set('n', '<leader>fw', function()
    vscode.call('editor.action.addSelectionToNextFindMatch')
    vscode.call('workbench.action.findInFiles')
end, { desc = 'Find Word Under Cursor' })

-- Navigation
vim.keymap.set('n', 'gd', function() vscode.call('editor.action.revealDefinition') end, opts)
vim.keymap.set('n', 'gr', function() vscode.call('editor.action.referenceSearch.trigger') end, opts)
vim.keymap.set('n', 'gi', function() vscode.call('editor.action.goToImplementation') end, opts)

-- Quick Fix & Refactor
vim.keymap.set('n', '<leader>.', function() vscode.call('editor.action.quickFix') end, opts)
vim.keymap.set('n', 'rn', function() vscode.call('editor.action.rename') end, opts)
vim.keymap.set('n', 'rf', function() vscode.call('editor.action.refactor') end, opts)

-- Hover & Actions
vim.keymap.set('n', 'K', function() vscode.call('editor.action.showHover') end, opts)
vim.keymap.set('n', 'ca', function() vscode.call('editor.action.showContextMenu') end, opts)
