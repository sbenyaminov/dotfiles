return {
    "tpope/vim-fugitive",
    config = function()
        -- Global mappings for Fugitive commands
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git) -- Open Git status
        vim.keymap.set("n", "<leader>gb", "<cmd>Git branch<CR>") -- Show Git branches
        vim.keymap.set("n", "<leader>gl", "<cmd>Git log<CR>") -- Show Git log
        vim.keymap.set("n", "<leader>gp", "<cmd>Git push<CR>") -- Push changes
        vim.keymap.set("n", "<leader>gpb", "<cmd>Git push -u origin<CR>") -- Push changes to upstream branch
        vim.keymap.set("n", "<leader>gr", "<cmd>Git pull --rebase<CR>") -- Pull with rebase
        vim.keymap.set("n", "<leader>gc", "<cmd>Git commit -v -q<CR>") -- Commit changes
        vim.keymap.set("n", "<leader>gca", "<cmd>Git commit --amend<CR>") -- Commit amend
        vim.keymap.set("n", "<leader>ga", "<cmd>Git add .<CR>") -- Add all changes

        -- Diff-specific mappings
        vim.keymap.set("n", "<leader>gd", "<cmd>Gdiff<CR>") -- Show Git diff
        vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>") -- Get changes from left side
        vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>") -- Get changes from right side
    end
}
