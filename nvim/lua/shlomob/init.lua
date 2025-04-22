require("shlomob.remap")
require("shlomob.set")
require("shlomob.lazy_init")

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        -- Delay it slightly to avoid race conditions with file opening
        vim.defer_fn(function()
            require("neo-tree.command").execute({
                action = "show",
                source = "filesystem",
                reveal = true,
                position = "left",
            })
            -- Go back to main window
            vim.cmd("wincmd p")
        end, 1)
    end,
})

vim.api.nvim_create_autocmd("WinClosed", {
    callback = function()
        vim.defer_fn(function()
            local wins = vim.api.nvim_list_wins()
            local normal_windows = 0

            for _, win in ipairs(wins) do
                local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
                if not string.find(bufname, "neo%-tree") then
                    normal_windows = normal_windows + 1
                end
            end

            -- If only neo-tree windows remain, quit Neovim
            if normal_windows == 0 then
                vim.cmd("qa")
            end
        end, 1)  -- Delay a bit so the window is actually closed
    end,
})

-- Change working directory to match the directory of any file opened via command line
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function(data)
        -- Only change directory if Neovim was started with a file argument
        local directory
        if vim.fn.argc() > 0 then
            local file = vim.fn.argv()[1]
            if vim.fn.isdirectory(file) ~= 1 then
                -- If a file was provided, change to its directory
                directory = vim.fn.fnamemodify(file, ":p:h")
            else
                -- If a directory was provided, use it directly
                directory = file
            end
            -- Change the directory
            vim.cmd("cd " .. directory)
            -- Optionally notify the user
            vim.notify("Working directory set to: " .. directory, vim.log.levels.INFO)
        end
    end,
    group = vim.api.nvim_create_augroup("change_dir_on_open", { clear = true }),
})
