-- Function to open a centered floating window with an array of strings
function set_colorscheme()
    local array = {"rose-pine", "oxocarbon"}
    local width = 20
    local height = #array
    local editor_width = vim.api.nvim_get_option('columns')
    local editor_height = vim.api.nvim_get_option('lines')

    local row = math.ceil((editor_height - height) / 2 - 1)
    local col = math.ceil((editor_width - width) / 2)

    -- Create a buffer for the floating window
    local buf = vim.api.nvim_create_buf(false, true)

    -- Set the buffer's lines to the array of strings
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, array)

    -- Define the floating window's options
    local opts = {
        style = 'minimal',
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col
    }

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Define a buffer variable to hold the selected index
    vim.api.nvim_buf_set_var(buf, 'selected_index', nil)

    vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', '', {
        noremap = true,
        silent = true,
        callback = function()
            local cursor = vim.api.nvim_win_get_cursor(win)
            local index = cursor[1]  -- The line number corresponds to the index in the array
            print("Selected index: " .. index .. ", Value: " .. array[index])

            -- Set background and numberline transparent
            vim.api.nvim_command("colorscheme " .. array[index])
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, 'LineNr', { bg = nil })

            vim.api.nvim_buf_set_var(buf, 'selected_index', index)
            vim.api.nvim_win_close(win, true)
        end
    })
end



-- Example usage with an array of strings
-- open_centered_float_with_array(my_strings)


-- Define the function globally or in an appropriate scope
_G.set_colorscheme = set_colorscheme

-- Now set the keymap to call the global function
vim.api.nvim_set_keymap('n', '<leader>cs', ':lua set_colorscheme()<CR>', { noremap = true, silent = true })

