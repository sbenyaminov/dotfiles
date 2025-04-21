return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
            callback = function(event)
                local opts = { buffer = event.buf }

                local keymap = vim.keymap.set
                local builtin = require('telescope.builtin')

                -- LSP go-to and info
                keymap('n', 'gd', builtin.lsp_definitions, opts)                   -- [G]oto [D]efinition
                keymap('n', 'gr', builtin.lsp_references, opts)                    -- [G]oto [R]eferences
                keymap('n', 'gI', builtin.lsp_implementations, opts)               -- [G]oto [I]mplementation
                keymap('n', '<leader>D', builtin.lsp_type_definitions, opts)      -- Type [D]efinition
                keymap('n', '<leader>ds', builtin.lsp_document_symbols, opts)     -- [D]ocument [S]ymbols
                keymap('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, opts) -- [W]orkspace [S]ymbols

                -- LSP actions
                keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)               -- [R]e[n]ame
                keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)         -- [C]ode [A]ction
                keymap('n', 'K', vim.lsp.buf.hover, opts)                         -- Hover Documentation
                keymap('n', 'gD', vim.lsp.buf.declaration, opts)                 -- [G]oto [D]eclaration

                -- Diagnostics
                keymap('n', '<leader>vd', vim.diagnostic.open_float, opts)
                keymap('n', '[d', vim.diagnostic.goto_next, opts)
                keymap('n', ']d', vim.diagnostic.goto_prev, opts)

                -- Signature help in insert mode
                keymap('i', '<C-h>', vim.lsp.buf.signature_help, opts)
            end
        })

        local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "pyright", "ts_ls", "eslint" },
            automatic_installation = false,
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = lsp_capabilities,
                    })
                end,
                lua_ls = function()
                    require("lspconfig").lua_ls.setup({
                        capabilities = lsp_capabilities,
                        settings = {
                            Lua = {
                                runtime = {
                                    version = "LuaJIT",
                                },
                                diagnostics = {
                                    globals = { "vim" },
                                },
                                workspace = {
                                    library = {
                                        vim.env.VIMRUNTIME,
                                    },
                                },
                            },
                        },
                    })
                end,
                pyright = function()
                    require("lspconfig").pyright.setup({
                        capabilities = lsp_capabilities,
                        settings = {
                            python = {
                                analysis = {
                                    typeCheckingMode = "basic", -- or "strict"
                                }
                            }
                        }
                    })
                end
            },
        })

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
            }),
            mapping = cmp.mapping.preset.insert({
                --	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                --	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
        })
    end,
}
