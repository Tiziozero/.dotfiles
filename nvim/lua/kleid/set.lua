vim.opt.guicursor = ""

-- control backspace deletes an entire work
vim.api.nvim_set_keymap('i', '<C-h>', '<C-w>', { noremap = true, silent = true }) -- Insert mode
vim.api.nvim_set_keymap('c', '<C-h>', '<C-w>', { noremap = true, silent = true }) -- Command mode



-- vim.opt.nu = true
-- vim.opt.relativenumber = true
vim.opt.mouse = ""

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.cmd([[
    autocmd FileType html setlocal shiftwidth=2
    autocmd FileType html setlocal tabstop=2
    autocmd FileType html setlocal expandtab
]])
vim.opt.smartindent = true

-- vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
-- vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
-- init.lua

--[[ vim.g.clipboard = {
  name = 'WslClipboard',
  copy = {
    ['+'] = 'clip.exe',
    ['*'] = 'clip.exe',
  },
  paste = {
    ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  },
  cache_enabled = 0,
} ]]--

-- vim.api.nvim_set_keymap('n', '<C-Tab>', ':tabnext<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-S-Tab>', ':tabprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':tabnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-S-Tab>', ':tabprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', { noremap = true, silent = true })

-- Set tab width to 2 spaces for specific file types
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"html", "css", "scss", "less", "javascript", "typescript", "typescriptreact", "javascriptreact", "json", "asm"},
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.expandtab = true
    end,
})



-- wierd html idiocracy
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.html", -- Adjust the pattern if needed
    command = "set filetype=html",
})

