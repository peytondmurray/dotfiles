require('packer').startup(function()

    use 'wbthomason/packer.nvim'

    use 'dstein64/vim-startuptime'
    use {'glepnir/galaxyline.nvim', branch = 'main', config = function() require('statusline') end}
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'
    use {'junegunn/vim-easy-align', keys = {'ga'}}

    -- File browser
    use {
        'kyazdani42/nvim-tree.lua',
        cmd = { "NvimTreeToggle", "NvimTreeClose" },
        config = function () require('nvimtree') end,
    }

    -- Toggle, display, and navigate marks
    use 'kshenoy/vim-signature'

    use 'heavenshell/vim-pydocstring'

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
    use {'windwp/nvim-autopairs', run = function() require('nvim-autopairs').setup() end}

    -- Check mapping conflicts with :CheckMappingConflicts
    use {'lukhio/vim-mapping-conflicts', cmd = 'CheckMappingConflicts'}

    -- Show a popup menu of keybindings when you press a button and wait for a bit
    use {'folke/which-key.nvim', config = function() require('which-key').setup{} end}

    -- Symbols browser
    use {'simrat39/symbols-outline.nvim', cmd = {'SymbolsOutline', 'SymbolsOutlineOpen', 'SymbolsOutlineClose'}}

    -- Indent guides
    use 'lukas-reineke/indent-blankline.nvim'

    -- User-defined text objects
    use 'kana/vim-textobj-user'

    -- Neovim in the browser
    use {'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end}

    -- Window motions: windows can be yanked/pasted
    use {'wesq3/vim-windowswap', keys = {'<C-W>'}}

    -- Colorschemes
    --[[ use {'npxbr/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}
    use 'Mofiqul/dracula.nvim' ]]
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
    use {"npxbr/glow.nvim", run = "GlowInstall"}

    -- Git Integration
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup{
                current_line_blame = true,
            }
        end
    }
    use {'sindrets/diffview.nvim', config = function() require('diffview').setup() end}

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
        config = function() require("trouble").setup{} end
    }

    -- Completion
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'
    use 'hrsh7th/nvim-compe'
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'

    -- Tree-sitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/playground'

    use {
        'akinsho/nvim-bufferline.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('bufferline').setup{
                options = {
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count)
                      return "("..count..")"
                    end,
                }
            }
        end
    }

end)

require('utils')
require('options')
require('keybindings')
require('treesitter')
require('lsp')
require('telescope').setup{
    colorscheme = {
        enable_preview = true,
    }
}
