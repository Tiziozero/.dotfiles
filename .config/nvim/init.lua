vim.lsp.set_log_level("ERROR")
vim.lsp.set_log_level("ERROR")
vim.opt.clipboard = "unnamedplus"

require("kleid")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- Example using a list of specs with the default options


require("lazy").setup({
	{
		"hrsh7th/nvim-cmp",
		-- load cmp on InsertEnter
		event = "InsertEnter",
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			-- ...
		end,
	},
    -- custom plugins
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			require("rose-pine").setup({
				dim_inactive_windows = true,
				groups = {
					background = 'base',
					background = 'none',
					background_nc = '_experimental_nc',
					panel = 'surface',
					panel_nc = 'base',
					border = 'highlight_med',
					-- comment = 'muted',
					comment = '#afa0ff',
					link = 'iris',
					punctuation = 'subtle',

					error = 'love',
					hint = 'iris',
					info = 'foam',
					warn = 'gold',

					headings = {
						h1 = 'iris',
						h2 = 'foam',
						h3 = 'rose',
						h4 = 'gold',
						h5 = 'pine',
						h6 = 'foam',
					}
					-- or set all headings at once
					-- headings = 'subtle'
				},
			})
			vim.cmd([[colorscheme rose-pine]])
		end,
	},
    -- require("kleid.lazy.lualine"),
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
          'vrischmann/tree-sitter-templ',
        },
        build = ':TSUpdate',
        config = function ()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = {"javascript", "typescript", "html"},
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = {"html", "htmlangular"},
                },
                indent = { enable = true },
                fold = { enable = true },
            }
            -- also do ":TSInstall javascript typescript html"
            vim.o.foldmethod = 'expr'
            vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
            vim.o.foldlevel = 99
            --[[
            --  zo {h,j,k,l}: to open fold
            --  zc: to close fold
            --  GPT said:
                zf{motion}: Create a fold for the specified motion.
                zo: Open a fold under the cursor.
                zc: Close a fold under the cursor.
                za: Toggle a fold under the cursor.
                zd: Delete a fold under the cursor.
                zR: Open all folds.
                zM: Close all folds.
            --]]
        end
    },
    {
        'windwp/nvim-ts-autotag',
        config = function() 
            require('nvim-ts-autotag').setup()
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = "v0.9.2",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')
            local telescope = require('telescope')

            local function open_in_new_tabs(prompt_bufnr)
                -- Ensure that picker is not nil before proceeding
                local picker = action_state.get_current_picker(prompt_bufnr)
                if not picker then
                    vim.notify("Picker is nil", vim.log.levels.ERROR)
                    print("Picker is nil")
                    return
                end
                print("Picker is not nil")


                local multi_selections = picker:get_multi_selection()


                -- If there are multiple selections, open them in new tabs
                if next(multi_selections) ~= nil then
                    for _, entry in ipairs(multi_selections) do
                        vim.cmd('tabedit ' .. entry.value)
                    end
                else

                    -- If there's only one selection, open it in a new tab
                    local entry = action_state.get_selected_entry()
                    if entry then
                        vim.cmd('tabedit ' .. entry.value)
                    else
                        vim.notify("No entry selected", vim.log.levels.ERROR)
                    end
                end

                actions.close(prompt_bufnr)
            end

            -- Setup Telescope with the custom action
            telescope.setup{
                defaults = {
                    mappings = {
                        i = {
                            ["<C-t>"] = open_in_new_tabs,
                        },
                        n = {
                            ["<C-t>"] = open_in_new_tabs,
                        },
                    },
                },
            }

            local builtin = require('telescope.builtin')
            vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Grep all files" })
            vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
            vim.keymap.set("n", "<C-p>", builtin.git_files, {})
            vim.keymap.set("n", "<leader>ps", function() 
                builtin.grep_string( { search = vim.fn.input("Grep > ") } )
            end)
        end
    },
    { 
        "rebelot/kanagawa.nvim",
        config = function()
            -- Default options:
            require('kanagawa').setup({
                compile = false,             -- enable compiling the colorscheme
                undercurl = true,            -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true},
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = true,         -- do not set background color
                dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
                terminalColors = true,       -- define vim.g.terminal_color_{0,17}
                --[[colors = {                   -- add/modify theme and palette colors
                    palette = {},
                    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
                }, ]]--
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none"
                            }
                        }
                    }
                },
                overrides = function(colors) -- add/modify highlights
                    return {}
                end,
                theme = "dragon",              -- Load "wave" theme when 'background' option is not set
                background = {               -- map the value of 'background' option to a theme
                    dark = "wave",           -- try "dragon" !
                    light = "lotus"
                },
            })

            -- setup must be called before loading
            vim.cmd("colorscheme kanagawa")
        end,
    },
    { 
        "nyoom-engineering/oxocarbon.nvim",
        config = function()
            require('oxocarbon')
            vim.opt.background = "dark"
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end,
    },
    {
        -- 'mg979/vim-visual-multi', branch = 'master'
    },
	{
        "ThePrimeagen/harpoon",
		dependencies = {
            "nvim-lua/plenary.nvim"
		},
		config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            vim.keymap.set("n", "<C-t>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-h>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
		end,
	},
    --[[{
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                theme = 'hyper', --  theme is doom and hyper default is hyper
                disable_move = true,    --  default is false disable move keymap for hyper
                config = {},    --  config used for theme
                hide = {
                  statusline,    -- hide statusline default is true
                  tabline,       -- hide the tabline
                  winbar        -- hide winbar
                },
                preview = {
                  command,       -- preview command
                  file_path,     -- preview file path
                  file_height,   -- preview file height
                  file_width    -- preview file width
                },
            }
        end,
        dependencies = { {'nvim-tree/nvim-web-devicons'}}
    },]] 
    require("kleid.lazy.lsp_config"),
})

-- Disable the default status line
vim.o.laststatus = 2

-- Enable status line only on the last window
vim.cmd([[
  autocmd WinEnter,BufWinEnter,FileType * setlocal laststatus=2
  autocmd WinLeave,BufWinLeave setlocal laststatus=0
]])

-- Custom status line
vim.o.statusline = "%F%m%r%h%w [%{&ff}] [%{&fileencoding}] [%Y] [%{strlen(&fenc)?&fenc:&enc}] %l,%c%V %P"


vim.api.nvim_command("colorscheme kanagawa")
vim.api.nvim_command("colorscheme rose-pine")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, 'LineNr', { bg = nil })

-- Disable the default status line
vim.o.laststatus = 2

-- Enable status line only on the last window
vim.cmd([[
  autocmd WinEnter,BufWinEnter,FileType * setlocal laststatus=2
  autocmd WinLeave,BufWinLeave setlocal laststatus=0
]])

-- Custom status line
-- vim.o.statusline = "%F%m%r%h%w [%{&ff}] [%{&fileencoding}] [%Y] [%{strlen(&fenc)?&fenc:&enc}] %l,%c%V %P"
vim.o.statusline = "%f %=%l,%c"
vim.lsp.set_log_level("ERROR")  -- or "WARN" for some warnings
