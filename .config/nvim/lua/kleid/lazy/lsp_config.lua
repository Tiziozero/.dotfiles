return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',
    },
    config = function()
        -- print("setting up lsp...")
        local cmp = require("cmp")

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-o>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),

            }),
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                    { name = 'buffer' },
                }),
        })

        vim.filetype.add({ extension = { templ = "templ" } })
        -- Mason initialisation
        require("mason").setup()
        require("mason-lspconfig").setup()

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- lsp key bindings
        local on_attach = function(_, _)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {} )
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {} )
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {} )
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {} )
            vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {} )
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {} )
        end

        -- initialise lsps
        local lsp = require("lspconfig")
        lsp.pyright.setup {
            on_attach = on_attach,
            capabilities = capabilities
        }
        lsp.rust_analyzer.setup {
            on_attach = on_attach,
            capabilities = capabilities
        }
        lsp.tsserver.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            -- cmd = { "bunx", "tsserver" },
        }
        lsp.htmx.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            -- filetypes = { "html", "templ", "jsx", "tsx" },
            filetypes = { "templ", "html", "htmldjango", "javascriptreact", "typescriptreact", "css", "sass", "scss", "less", "javascript", "typescript" },
        }
        lsp.html.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            -- filetypes = { "html", "templ", "jsx", "tsx" },
            filetypes = { "templ", "html", "htmlangular", "html.angular", "htmldjango", "javascriptreact", "typescriptreact", "css", "sass", "scss", "less", "javascript", "typescript" },
        }
        --[[ lsp.clangd.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        } ]]--
        lsp.gopls.setup {
            cmd = {"gopls"},  -- Ensure no verbose flags are present
            settings = {
                gopls = {
                    verboseOutput = false,  -- Disable verbose logging if applicable
                },
            },
            -- on_attach = on_attach,
            on_attach = on_attach,
            capabilities = capabilities,
        }
        lsp.lua_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
        lsp.cssls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "css", "html", "templ", "jsx", "tsx" },
        }
        lsp.tailwindcss.setup {
            on_attach = on_attach,
            capabilities = capabilities,

            filetypes = { "templ", "html", "htmldjango", "javascriptreact", "typescriptreact", "css", "sass", "scss", "less", "javascript", "typescript" },
        }
        lsp.templ.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "templ" },
        }
        lsp.bashls.setup {
            on_attach = on_attach,
            capabilities = capabilities
        }
        lsp.ols.setup {
            on_attach = on_attach,
            capabilities = capabilities
        }
        lsp.asm_lsp.setup {
            on_attach = on_attach,
            capabilities = capabilities
        }
        vim.lsp.set_log_level("debug")
    end,
}
