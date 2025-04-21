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
  
