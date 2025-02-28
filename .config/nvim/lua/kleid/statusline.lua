vim.o.showmode = true
vim.o.ruler = true
vim.o.laststatus = 2
vim.o.statusline = '%f %r%=%l/%L [%v] '


function fp()
        vim.o.statusline = '%f %r%=%l/%L [%v] '
        print("Showing file name")
end

function np()
        vim.o.statusline = '%=%l/%L [%v] '
        print("No file path")
end


-- bg transparent
function sb()
        vim.cmd[[highlight StatusLine guibg=NONE ctermbg=NONE]]
        print("Hello UwU")
end


vim.defer_fn(function()
        vim.cmd[[hi StatusLine guibg=NONE ctermbg=NONE]]
        vim.cmd[[hi StatusLineNC guibg=NONE ctermbg=NONE]]
end, 0)


