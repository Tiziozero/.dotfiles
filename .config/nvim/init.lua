-- everything works for me
vim.g.mapleader = " "
vim.opt.swapfile = false
vim.opt.winborder = "rounded"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.showtabline = 4
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.wrap = true
-- vim.opt.cursorcolumn = false
vim.opt.colorcolumn = "80"



vim.pack.add({
    { src = "https://github.com/nyoom-engineering/oxocarbon.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/ThePrimeagen/harpoon" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/vrischmann/tree-sitter-templ" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },

    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
})
-- make background transparent
vim.cmd[[colorscheme oxocarbon ]]
vim.opt.background = "dark"
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "Statusline", { bg = "none" })

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, 'LineNr', { bg = nil })

vim.cmd[[hi StatusLine guibg=NONE ctermbg=NONE]]
vim.cmd[[hi StatusLineNC guibg=NONE ctermbg=NONE]]

-- harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-t>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-h>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

-- treesitter
--[[ require'nvim-treesitter.configs'.setup {
    ensure_installed = {"javascript", "typescript", "html"},
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = {"html", "htmlangular"},
    },
    indent = { enable = true },
    fold = { enable = true },
} ]]--
require'nvim-treesitter'.install { 'rust', 'javascript', 'zig' }
-- vim.cmd[[TSUpdate]]

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Grep all files" })
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function() 
    builtin.grep_string( { search = vim.fn.input("Grep > ") } )
end)


function silly_mason_bs()
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
    require("mason").setup()
    require("mason-lspconfig").setup()



end
silly_mason_bs()


-- other remaps
-- move lines with K/J
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- control backspace delete work
vim.api.nvim_set_keymap('i', '<C-h>', '<C-w>', { noremap = true, silent = true }) -- Insert mode
vim.api.nvim_set_keymap('c', '<C-h>', '<C-w>', { noremap = true, silent = true }) -- Command mode
-- vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>', { noremap = true, silent = true }) -- Normal mode

-- copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("i", "<C-c>", "<Esc>")
-- tabs
vim.api.nvim_set_keymap('n', '<S-Tab>', ':tabnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-S-Tab>', ':tabprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', { noremap = true, silent = true })

-- add gala as rust highlight
vim.filetype.add({
  extension = {
    gala = "rust",
  },
})
