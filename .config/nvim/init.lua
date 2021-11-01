require('packer').startup(function()

    use 'wbthomason/packer.nvim'

    use {'glepnir/galaxyline.nvim', branch = 'main', config = function() require('statusline') end}
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'
    use 'junegunn/vim-easy-align'

   use {
       'kkoomen/vim-doge',
       run = function() vim.fn['doge#install']() end,
   }

   -- DAP
   use 'mfussenegger/nvim-dap'
   use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }


    -- File browser
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        cmd = { "NvimTreeToggle", "NvimTreeClose" },
    }

    -- Toggle, display, and navigate marks
    use 'kshenoy/vim-signature'

    use {
        'heavenshell/vim-pydocstring',
        cmd = {"Pydocstring", "PydocstringFormat"}
    }

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
    use {'windwp/nvim-autopairs', config = require('nvim-autopairs').setup() }

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

    -- Dim inactive windows
    use {
        'sunjon/shade.nvim',
        config = function()
            require'shade'.setup({
                overlay_opacity = 50,
                opacity_step = 1,
                keys = {
                    brightness_up    = '<C-Up>',
                    brightness_down  = '<C-Down>',
                    toggle           = '<Leader>s',
                }
            })
        end
    }
    -- Colorschemes
    -- use 'Mofiqul/dracula.nvim'
    use 'EdenEast/nightfox.nvim'
    use 'folke/tokyonight.nvim'

    -- Colorize hex codes
    use {
        'norcalli/nvim-colorizer.lua',
        event = "BufReadPre",
        config = function()
            require('colorizer').setup()
        end
    }

    -- Markdown with glow
    use {"npxbr/glow.nvim", run = "GlowInstall", cmd = "Glow"}

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
    use 'hrsh7th/nvim-compe'
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'

    -- Tree-sitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use {'nvim-treesitter/playground', cmd = "TSPlaygroundToggle"}

end)

require('utils')
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
