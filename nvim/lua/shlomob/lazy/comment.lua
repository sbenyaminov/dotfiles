return {
    'numToStr/Comment.nvim',
    opts = {},
    config = function()
        local opts = { noremap = true, silent = true }

        -- Line comments (both Ctrl-/ and Ctrl-_)
        -- on MacOS and wezterm Ctrl / actually maps to Ctrl _ so we will map both
        vim.keymap.set('n', '<C-_>', require('Comment.api').toggle.linewise.current, opts)
        vim.keymap.set('v', '<C-_>', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
        vim.keymap.set('n', '<C-/>', require('Comment.api').toggle.linewise.current, opts)
        vim.keymap.set('v', '<C-/>', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)

        -- Block comments (Ctrl-c)
        vim.keymap.set('n', '<C-c>', require('Comment.api').toggle.blockwise.current, opts)
        vim.keymap.set('v', '<C-c>', "<ESC><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<cr>", opts)
    end,
}
