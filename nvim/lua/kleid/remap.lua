vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/kleid/packer.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set('n', '<Leader>sb', [[:lua sb()<CR>]], { noremap = true, silent = true })
-- show file path
vim.keymap.set('n', '<Leader>fp', [[:lua fp()<CR>]], { noremap = true, silent = true })
-- no file pato
vim.keymap.set('n', '<Leader>np', [[:lua np()<CR>]], { noremap = true, silent = true })


-- Map <leader>h to call the custom function
vim.keymap.set('n', '<leader>h', [[:lua show_custom_text()<CR>]], { noremap = true, silent = true })
vim.keymap.set('n', '<leader>w', [[:lua show_custom_text_right()<CR>]], { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>h', [[:lua help_win()<CR>]], { noremap = true, silent = true })
-- doesnt work. the line above
vim.keymap.set('n', 'qq', ':bd<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>com', '[[:terminal ./build.sh<CR>]]', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>crn', '[[:terminal cargo run<CR>]]', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rl', ':lua ReloadConfig()<CR>', { noremap = true, silent = true })

-- up-down error navigation
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.goto_next()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>u', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {noremap = true, silent = true})

