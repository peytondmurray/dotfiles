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

require("lazy").setup({

    {
        "vigoux/notifier.nvim",
        config = function()
            require('notifier').setup({})
        end
    },
    -- {
    --     "luukvbaal/statuscol.nvim",
    --     config = function()
    --         require("statuscol").setup()
    --     end
    -- },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {'nvim-web-devicons'},
    },
    'kyazdani42/nvim-web-devicons',
    'junegunn/vim-easy-align',

    {
        'luukvbaal/stabilize.nvim',
        config = function() require('stabilize').setup() end
    },

    'glench/vim-jinja2-syntax',
    'jxnblk/vim-mdx-js',

    {
        'danymat/neogen',
        config = function()
            require('neogen').setup {
                enabled = true,
                languages = {
                    python = {
                        template = {
                            annotation_convention = 'numpydoc'
                        }
                    }
                }
            }
        end
    },

    {
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup()
        end
    },

    -- DAP
    'mfussenegger/nvim-dap',
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio',
        }
    },
    {
        'leoluz/nvim-dap-go',
        config = function()
            require('dap-go').setup({
                dap_configurations = {
                    {
                        type = "go",
                        name = "Attach remote",
                        mode = "remote",
                        request = "attach",
                        program = "${workspaceFolder}/main.go",
                    },
                  }
            })
        end
    },

    -- File browser
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = {'kyazdani42/nvim-web-devicons'},
        config = function()
            require("nvim-tree").setup({
                filters = {
                    custom = { "^\\.git$" }
                }
            })
        end
    },

    -- Toggle, display, and navigate marks
     'kshenoy/vim-signature',
    'windwp/nvim-ts-autotag',

    -- Check mapping conflicts with :CheckMappingConflicts
    {'lukhio/vim-mapping-conflicts', cmd = 'CheckMappingConflicts'},

    -- Show a popup menu of keybindings when you press a button and wait for a bit
    {'folke/which-key.nvim', config = function() require('which-key').setup{} end},

    -- Symbols browser
    {
        "hedyhli/outline.nvim",
        config = function()
            require("outline").setup({
                symbols = {
		            filter = {
                        python = { 'Function', 'Class' },
	                }
                }
            })
        end,
    },

    -- Indent guides
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('ibl').setup({
                indent = {
                    char = '│'
                },
                scope = {
                    enabled = true,
                }
            })
        end
    },

    -- Neovim in the browser
    {
        'glacambre/firenvim',
        build = ":call firenvim#install(0)",
    },

    -- Colorschemes
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                styles = {
                    italic = false
                },
                highlight_groups = {
                    Cursor = {
                        fg = "gold"
                    }
                }
            })
        end
    },
    -- 'savq/melange',
    --  'Mofiqul/dracula.nvim'
    --  'EdenEast/nightfox.nvim'
    --  'folke/tokyonight.nvim'
    --  {
    --     'ellisonleao/gruvbox.nvim',
    --     config = function()
    --         require('gruvbox').setup({
    --             italic = false
    --         })
    --     end
    -- }

    'rktjmp/lush.nvim',
    {
        'echasnovski/mini.nvim',
        version = false,
        config = function()
            require('mini.ai').setup()
            require('mini.align').setup()
            require('mini.comment').setup({
                mappings = {
                    comment = ' c',
                    comment_line = ' c',
                    comment_visual = ' c',
                    textobject = '',
                }
            })
            require('mini.pairs').setup()
            require('mini.cursorword').setup()
            require('mini.hipatterns').setup({
                highlighters = {
                    hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
                }
            })
        end
    },
    -- Git Integration
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup{
                current_line_blame = true,
            }
        end
    },
    {
        'sindrets/diffview.nvim',
        config = function() require('diffview').setup() end,
        cmd = {
            'DiffviewOpen'
        }
    },
    'tpope/vim-fugitive',

    -- Telescope
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },
    'nvim-lua/plenary.nvim',
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-telescope/telescope-live-grep-args.nvim'
        },
    },
    'xiyaowong/telescope-emoji.nvim',

    -- Completion
    -- https://github.com/SmiteshP/nvim-navic
    'neovim/nvim-lspconfig',
    {
        'saghen/blink.cmp',
        dependencies = {
            'rafamadriz/friendly-snippets'
        },
        version = '1.*',
        opts = {
            keymap = {
                preset = 'enter',

                ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
                ['<C-j>'] = { 'select_next', 'fallback_to_mappings' },
                ['<Esc>'] = { 'cancel', 'fallback' },
                ['<CR>'] = { 'select_and_accept', 'fallback_to_mappings' },
            },
            completion = { documentation = { auto_show = true } },
            sources = {
                default = {'lazydev', 'lsp', 'path', 'snippets', 'buffer'},
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
        }
    },
    'folke/lazydev.nvim',
    {
        'ray-x/lsp_signature.nvim',
        config = function() require('lsp_signature').setup() end,
    },
    {
        'j-hui/fidget.nvim',
        tags = '*'
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        lazy = false,   -- This plugin is already lazy
        config = function()
            vim.g.rustaceanvim = {
                server = {
                    ra_multiplex = {
                        enable = false,
                    }
                },
            }
        end
    },
    'p00f/clangd_extensions.nvim',

    -- Tree-sitter
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter',
                build = ':TSUpdate',
                event = { 'BufRead', 'BufNewFile', 'InsertEnter' }
            },

        },
    },
    'nvim-treesitter/nvim-treesitter-context',
    {
        "chrisgrieser/nvim-various-textobjs",
        config = function ()
            require("various-textobjs").setup({ keymaps = { useDefaults = true }})
        end,
    },

    -- Line diffs
    'AndrewRadev/linediff.vim',

    'jbyuki/venn.nvim',
    {
        'terrastruct/d2-vim',
        ft = { 'd2' }
    },

    -- Discord presence
    'andweeb/presence.nvim',
})


require('options')
require('statusline')
require('keybindings')
require('treesitter')
require('dapconfig')
require('telescope').setup{
    colorscheme = {
        enable_preview = true,
    },
    pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
    winblend = 20,
    defaults = {
        file_ignore_patterns = {
            'node_modules/',
            'yarn.lock',
            'compile_commands.json'
        },
    },
    extensions = {
        live_grep_args = {
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--hidden",
                "--glob=!.git/",
            }
        }
    }
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')
require('telescope').load_extension('emoji')
require('styles')
require('tree')
require('lsp')
