require('packer').startup(function()

    use 'wbthomason/packer.nvim'

    use {
        'dstein64/vim-startuptime',
        cmd = {
            "StartupTime"
        }
    }
    use({
        'mvllow/modes.nvim',
        config = function()
            vim.opt.cursorline = true
            require('modes').setup()
        end
    })

    use({
        "nvim-lualine/lualine.nvim",
        config = function() require('statusline') end,
        wants = "nvim-web-devicons",
    })
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'
    use 'junegunn/vim-easy-align'

    use {
        "luukvbaal/stabilize.nvim",
        config = function() require("stabilize").setup() end
    }

    use 'jxnblk/vim-mdx-js'

    use {
        "danymat/neogen",
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
        end,
        requires = "nvim-treesitter/nvim-treesitter"
    }


    -- DAP
    use 'mfussenegger/nvim-dap'
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }


    -- File browser
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
    }

    -- Toggle, display, and navigate marks
    use 'kshenoy/vim-signature'

    -- Highlight same words as currently hovered word
    use 'rrethy/vim-illuminate'

    -- Comment a line, selection, or motion
    use {
        'b3nj5m1n/kommentary',
        config = function()
            require('kommentary.config').configure_language(
                'default',
                {prefer_single_line_comments = true}
            )
        end
    }

    -- Automatically create bracket pairs, etc
    use {
        "steelsojka/pears.nvim",
        config = function() require("pears").setup(
            function(conf)
                conf.expand_on_enter(true)
            end
            ) end
    }
    use 'windwp/nvim-ts-autotag'

    -- Check mapping conflicts with :CheckMappingConflicts
    use {'lukhio/vim-mapping-conflicts', cmd = 'CheckMappingConflicts'}

    -- Show a popup menu of keybindings when you press a button and wait for a bit
    use {'folke/which-key.nvim', config = function() require('which-key').setup{} end}

    -- Symbols browser
    use {'simrat39/symbols-outline.nvim', cmd = {'SymbolsOutline', 'SymbolsOutlineOpen', 'SymbolsOutlineClose'}}

    -- Indent guides
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup{
                show_current_context = true
            }
        end
    }

    -- User-defined text objects
    use 'kana/vim-textobj-user'
    use 'kana/vim-textobj-line'

    -- Neovim in the browser
    use {'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end}

    -- Window motions: windows can be yanked/pasted
    use {'wesq3/vim-windowswap', keys = {'<C-W>'}}

    -- Colorschemes
    -- use 'Mofiqul/dracula.nvim'
    use 'EdenEast/nightfox.nvim'
    -- use 'folke/tokyonight.nvim'

    -- Colorize hex codes
    use {
        'norcalli/nvim-colorizer.lua',
        event = "BufReadPre",
        config = function()
            require('colorizer').setup()
        end
    }

    -- Add ANSI escape sequence support
    use {
        'norcalli/nvim-terminal.lua',
        config = function()
            require('terminal').setup()
        end
    }

    -- Git Integration
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup{
                current_line_blame = true,
                keymaps = {},
            }
        end
    }
    use {
        'sindrets/diffview.nvim',
        config = function() require('diffview').setup() end,
        cmd = {
            "DiffviewOpen"
        }
    }
    use 'tpope/vim-fugitive'

    -- Telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use {
        'nvim-telescope/telescope.nvim',
    }

    -- Trouble
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function() require("trouble").setup{} end,
        cmd = {
            "Trouble",
            "TroubleToggle"
        }
    }

    -- Completion
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'rafamadriz/friendly-snippets'
    use {
        'ray-x/lsp_signature.nvim',
        config = function() require('lsp_signature').setup() end
    }

    -- Tree-sitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use {'nvim-treesitter/playground', cmd = "TSPlaygroundToggle"}

    -- Python
    use 'vimjas/vim-python-pep8-indent'

end)

-- require('luautils')
require('options')
require('keybindings')
require('treesitter')
require('lsp')
require('dapconfig')
require('telescope').setup{
   colorscheme = {
       enable_preview = true,
   },
   winblend = 20,
   defaults = {
       file_ignore_patterns = {
           'node_modules/',
           'yarn.lock'
       }
   }
}
require('styles')
require('tree')
require('statusline')
