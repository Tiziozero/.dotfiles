function show_custom_text_right()
    local text = {
        "File Path commands:",
        "       <leader>fp to show file path", 
        "       <leader>np for no file path",
        "Git commands(vim fugitive):",
        "       <leader>gs to open window",
        "       cc to open commit window",
        "       <leader>p to push",
        "       <leader>P to pull",
        "Colorschemes('colorscheme <colorscheme>')",
        "       kanagawa",
        "       rose-pine",

    }

    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, text)

    local win_id = vim.api.nvim_open_win(bufnr, true, {
        relative = 'editor',
        width = 40,
        height = vim.api.nvim_get_option('lines') - 4,
        row = 2,
        col = vim.api.nvim_get_option('columns') - 31,  -- Adjust the column to place it on the right
        style = 'minimal',
        focusable = false,
    })

    vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '<Cmd>q!<CR>', { noremap = true, silent = true })
    vim.api.nvim_win_set_option(win_id, 'number', false)
end




function show_floating_window()
    local text = {'This is some custom text.', 'You can edit or close this window.'}
    local options = {
        relative = 'editor',
        width = 40,
        height = 2,
        row = 5,
        col = 5,
        style = 'minimal',
    }
    local bufnr = vim.api.nvim_create_buf(false, true)
    local win_id = vim.api.nvim_open_win(bufnr, 0, options)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, text)
    vim.api.nvim_win_set_option(win_id, 'modifiable', false)
end


