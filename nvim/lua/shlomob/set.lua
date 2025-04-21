-- Show absolute line numbers on the left
vim.opt.nu = true

-- Show relative line numbers (useful for line-wise motions like 5j or 3k)
vim.opt.relativenumber = true

-- Set number of spaces a <Tab> appears as
vim.opt.tabstop = 4

-- Number of spaces inserted when pressing <Tab> in insert mode
vim.opt.softtabstop = 4

-- Number of spaces used when auto-indenting (e.g., with >>)
vim.opt.shiftwidth = 4

-- Convert tabs to spaces automatically
vim.opt.expandtab = true

-- Smart auto-indenting when starting new lines
vim.opt.smartindent = true

-- Make search case-insensitive unless uppercase letters are used
vim.o.ignorecase = true
vim.o.smartcase = true

-- Don't wrap long lines (keeps lines on one line horizontally)
vim.opt.wrap = false

-- Disable swap files (less clutter, but no crash recovery)
vim.opt.swapfile = false

-- Disable backup files (same reason as swap)
vim.opt.backup = false

-- Directory to store undo history
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Enable persistent undo (keeps undo history across restarts)
vim.opt.undofile = true

-- Don't highlight all search results after search
vim.opt.hlsearch = true

-- Show matches while you're typing the search
vim.opt.incsearch = true

-- Enable 24-bit (true) color support in terminal
vim.opt.termguicolors = true

-- Keep lines visible above/below the cursor while scrolling
vim.opt.scrolloff = 15

-- Always show the sign column (e.g. for Git or diagnostics)
vim.opt.signcolumn = "yes"

-- Allow "@" in filenames (some CLI tools use it)
vim.opt.isfname:append("@-@")

-- Decrease time before CursorHold events trigger (used by plugins like LSP)
vim.opt.updatetime = 50

-- Show a vertical line at column 100 (good coding style reminder)
vim.opt.colorcolumn = "100"

vim.o.splitbelow = true -- force all horizontal splits to go below current window
vim.o.splitright = true -- force all vertical splits to go to the right of current window

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
        higroup = 'IncSearch',
        timeout = 300,
    })
  end,
  group = highlight_group,
  pattern = '*',
})
