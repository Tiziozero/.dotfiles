-- everything works for me
vim.g.mapleader = " "
vim.opt.swapfile = false
vim.opt.winborder = "rounded"
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
-- vim.opt.showtabline = 4
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.wrap = true
-- vim.opt.cursorcolumn = false
vim.opt.colorcolumn = "80"
vim.opt.mouse = ""
-- show tab/spaces
vim.opt.list = true
vim.opt.listchars = {
  tab = "▸ ",
  space = "·",
  trail = "·",
}





vim.pack.add({
    { src = "https://github.com/nyoom-engineering/oxocarbon.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/ThePrimeagen/harpoon" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate" },
    { src = "https://github.com/vrischmann/tree-sitter-templ" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },

    { src = "https://github.com/ellisonleao/gruvbox.nvim.git" }, -- cholorscheme

    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/ej-shafran/compile-mode.nvim" },
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
-- vim.cmd[[TSUpdate]]

-- telescope
require('telescope').setup{
  defaults = {
    preview = {
      treesitter = false,
    },
  },
}
local builtin = require('telescope.builtin')
vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Grep all files" })
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})

local function silly_mason_bs()
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
    -- gala = "rust",
  },
})
-- old remaps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- replace in file under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- "Compile"
vim.keymap.set({"n", "v"}, "<leader>c", ":below Compile<CR>")
-- next error
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.goto_next()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>u', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {noremap = true, silent = true})

-- test cholorscheme
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

-- Default options:
require("gruvbox").setup({
  terminal_colors = false, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "soft", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")

vim.cmd.colorscheme("monokai-dimmed")

-- background
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Statusline", { bg = "none" })

-- statusline bs
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, 'LineNr', { bg = nil })

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "Statusline", { bg = "none" })
vim.cmd[[hi StatusLine guibg=NONE ctermbg=NONE]]
vim.cmd[[hi StatusLineNC guibg=NONE ctermbg=NONE]]

-- expand tab golan
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.bo.expandtab = true
        vim.bo.shiftwidth = 4
        vim.bo.tabstop = 4
    end,
})
