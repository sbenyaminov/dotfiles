-- Show relative line numbers (useful for line-wise motions like 5j or 3k)
-- Note: VSCode will handle the actual display of line numbers
vim.opt.relativenumber = true

-- Use system clipboard for all operations
-- vim.opt.clipboard = "unnamedplus"

-- Make search case-insensitive unless uppercase letters are used
vim.o.ignorecase = true
vim.o.smartcase = true

-- Show matches while you're typing the search
vim.opt.incsearch = true

-- Don't highlight all search results after search (VSCode has its own search highlighting)
vim.opt.hlsearch = false

-- Keep lines visible above/below the cursor while scrolling
vim.opt.scrolloff = 15

-- Decrease time before CursorHold events trigger
vim.opt.updatetime = 50

vim.o.splitbelow = true -- force all horizontal splits to go below current window
vim.o.splitright = true -- force all vertical splits to go to the right of current windo

-- Highlight on yank (this still works in VSCode mode)
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
