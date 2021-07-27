require('packer').startup(function()

    use 'wbthomason/packer.nvim'

    use 'dstein64/vim-startuptime'
    use {'glepnir/galaxyline.nvim', branch = 'main', config = require('statusline')}
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'
    use 'junegunn/vim-easy-align'

    use 'kyazdani42/nvim-tree.lua'

    -- Toggle, display, and navigate marks
    use 'kshenoy/vim-signature'

    use 'heavenshell/vim-pydocstring'

    -- Highlight same words as currently hovered word
    use 'rrethy/vim-illuminate'

    -- Comment a line, selection, or motion
    use 'b3nj5m1n/kommentary'

    -- Automatically create bracket pairs, etc
    use {'windwp/nvim-autopairs', run = require('nvim-autopairs').setup() }

    -- Check mapping conflicts with :CheckMappingConflicts
    use 'lukhio/vim-mapping-conflicts'

    -- Show a popup menu of keybindings when you press a button and wait for a bit
    use {'folke/which-key.nvim', config = require('which-key').setup{}}

    -- Symbols browser
    use 'simrat39/symbols-outline.nvim'

    -- Indent guides
    use 'lukas-reineke/indent-blankline.nvim'

    -- User-defined text objects
    use 'kana/vim-textobj-user'

    -- Neovim in the browser
    use {'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end}

    -- Window motions: windows can be yanked/pasted
    use 'wesq3/vim-windowswap'

    -- Colorschemes
    use {'npxbr/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}
    use 'Mofiqul/dracula.nvim'

    -- Colorize hex codes
    use 'norcalli/nvim-colorizer.lua'

    -- Git Integration
    use {
        'lewis6991/gitsigns.nvim',
        config = require('gitsigns').setup{
            current_line_blame = true,
        }
    }
    use 'sindrets/diffview.nvim'

    -- Telescope----
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

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

end)

require('utils')
require('options')
require('keybindings')

-- Telescope
require('telescope').setup{
    colorscheme = {
        enable_preview = true,
    }
}

require('treesitter')
require('lsp')

-- Kommentary
require('kommentary.config').configure_language(
    'default',
    {prefer_single_line_comments = true}
)

-- Set up colorizer; must be done after termguicolors is set
require('colorizer').setup()

-- NvimTree
local tree_cb = require('nvim-tree.config').nvim_tree_callback
vim.g.nvim_tree_bindings = {
    { key = {'<CR>', 'e'},                  cb = tree_cb('edit') },
    { key = 'l',                            cb = tree_cb('cd') },
    { key = 'v',                            cb = tree_cb('vsplit') },
    { key = 's',                            cb = tree_cb('split') },
    { key = 't',                            cb = tree_cb('tabnew') },
    { key = 'h',                            cb = tree_cb('dir_up') },
}

require('diffview').setup()
