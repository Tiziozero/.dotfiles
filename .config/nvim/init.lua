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
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
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
-- nvim compile mode
vim.g.compile_mode = {
    -- The string to show in the compile prompt as a default.
    -- For an empty prompt, you can use:
    -- default_command = "",
    -- To use different defaults based on filetype, you can use a table:
    -- default_command = {
    --   python = "python %",
    --   lua = "lua %",

    --   javascript = "bun %",
    --   typescript = "bun %",
    --   c = "cc -o %:r % && ./%:r",
    --   cpp = "cc -std=c++23 -o %:r % && ./%:r",
    --   java = "javac % && java %:r",
    --   go = "go run %",
    -- },
    -- A function which returns the default command string is also supported:
    -- default_command = function()
    --   local filetype = vim.bo.filetype
    --   if filetype == "python" then
    --     return "python %"
    --   else
    --     return "make -k "
    --   end
    -- end,
    -- :h compile_mode.default_command
    default_command = "make -k ",
    -- Use `baleia` for parsing ANSI escape codes in the output.
    -- :h compile_mode.baleia_setup

    baleia_setup = false,
    -- Expand commands, like `:!` (e.g. `:Compile echo %`)
    -- :h compile_mode.bang_expansion
    bang_expansion = false,
    -- Configure additional error regexes.
    -- :h compile-mode-errors
    error_regexp_table = {},
    -- List of filename regexes to ignore errors from.

    -- :h compile-mode.error_ignore_file_list
    error_ignore_file_list = {},
    -- The minimum error level to jump to.
    -- :h compile-mode.error_threshold
    error_threshold = require("compile-mode").level.WARNING,
    -- Automatically jump to the first error.
    -- :h compile-mode.auto_jump_to_first_error

    auto_jump_to_first_error = false,
    -- How long to highlight an error's location when jumping to it.
    -- :h compile-mode.error_locus_highlight
    error_locus_highlight = 500,
    -- Use Neovim diagnostics instead of opening the compilation buffer.

    -- :h compile-mode.use_diagnostics
    use_diagnostics = false,
    -- Default to calling `:Compile` for `:Recompile`

    -- when there's no previous command.
    -- :h compile-mode.recompile_no_fail
    recompile_no_fail = false,
    -- Ask to save unsaved buffers before compiling.
    -- :h compile-mode.ask_about_save
    ask_about_save = true,
    -- Ask to interrupt already running commands.
    -- :h compile-mode.ask_to_interrupt

    ask_to_interrupt = true,
    -- The name for the compilation buffer.

    -- :h compile-mode.buffer_name
    buffer_name = "*compilation*",
    -- The format for the time information
    -- at the top of the compilation buffer
    -- :h compile-mode.time_format
    time_format = "%a %b %e %H:%M:%S",
    -- List of regexes to hide from the output.
    -- :h compile-mode.hidden_output
    hidden_output = {},
    -- A table of environment variables to pass to commands.
    -- :h compile-mode.environment
    environment = nil,
    -- Clear all environment variables for each command.
    -- :h compile-mode.clear_environment
    clear_environment = false,
    -- Fix compilation for plugins like `nvim-cmp`.
    -- :h compile-mode.input_word_completion
    input_word_completion = false,
    -- Hide the compliation buffer.
    -- :h compile-mode.hidden_buffer
    hidden_buffer = false,
    -- Automatically focus the compilation buffer.
    -- :h compile-mode.focus_compilation_buffer
    focus_compilation_buffer = false,
    -- Automatically move the cursor to the end of the compilation buffer.
    -- :h compile-mode.auto_scroll
    auto_scroll = true,
    -- Jump back past the end/beginning of the errors
    -- with `:NextError`/`:PrevError`
    -- :h compile-mode.use_circular_error_navigation
    use_circular_error_navigation = false,
    -- Print debug information.
    -- :h compile-mode.debug
    debug = false,
    -- Use a pseudo terminal for command execution.
    -- :h compile-mode.use_pseudo_terminal
    use_pseudo_terminal = false,
}


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

vim.cmd[[hi StatusLine guibg=NONE ctermbg=NONE]]
vim.cmd[[hi StatusLineNC guibg=NONE ctermbg=NONE]]
