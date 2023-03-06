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
    { 'dstein64/vim-startuptime', cmd = {
            'StartupTime'
        }
    },

    'SmiteshP/nvim-gps',

    {
        "luukvbaal/statuscol.nvim",
        config = function()
            require("statuscol").setup()
        end
    },
    {
        'feline-nvim/feline.nvim',
        dependencies = {'nvim-web-devicons'},
    },
    --  'ryanoasis/vim-devicons'
    'kyazdani42/nvim-web-devicons',
    'junegunn/vim-easy-align',

    {
        'luukvbaal/stabilize.nvim',
        config = function() require('stabilize').setup() end
    },

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
    { 'rcarriga/nvim-dap-ui', requires = {'mfussenegger/nvim-dap'} },


    -- File browser
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = {'kyazdani42/nvim-web-devicons'},
    },

    -- Toggle, display, and navigate marks
     'kshenoy/vim-signature',

    -- Highlight same words as currently hovered word
     'rrethy/vim-illuminate',

    -- Comment a line, selection, or motion
     {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                mappings = {
                    basic = false,
                    extra = false,
                }
            })
        end
    },

     {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({
                check_ts = true,
            })
        end
    },
     'windwp/nvim-ts-autotag',

    -- Check mapping conflicts with :CheckMappingConflicts
     {'lukhio/vim-mapping-conflicts', cmd = 'CheckMappingConflicts'},

    -- Show a popup menu of keybindings when you press a button and wait for a bit
     {'folke/which-key.nvim', config = function() require('which-key').setup{} end},

    -- Symbols browser
     {
        'simrat39/symbols-outline.nvim',
        cmd = {'SymbolsOutline', 'SymbolsOutlineOpen', 'SymbolsOutlineClose'},
        config = function()
            require('symbols-outline').setup()
        end
    },

    -- Indent guides
     {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup{
                show_current_context = true,
                show_current_context_start = true,
                use_treesitter = true,
                blankline_char = '│'
            }
        end
    },

    -- User-defined text objects
     'kana/vim-textobj-user',
     -- 'kana/vim-textobj-line',

    -- Neovim in the browser
     {'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end},

    -- Window motions: windows can be yanked/pasted
     {'wesq3/vim-windowswap', keys = {'<C-W>'}},

    -- Colorschemes
     'savq/melange',
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

    -- Colorize hex codes
     {
        'norcalli/nvim-colorizer.lua',
        event = 'BufReadPre',
        config = function()
            require('colorizer').setup()
        end
    },

    -- Add ANSI escape sequence support
     {
        'norcalli/nvim-terminal.lua',
        config = function()
            require('terminal').setup()
        end
    },

    -- Git Integration
     {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup{
                current_line_blame = true,
                keymaps = {},
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
     'nvim-lua/popup.nvim',
     'nvim-lua/plenary.nvim',
     {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-telescope/telescope-live-grep-args.nvim'
        }
    },
     'xiyaowong/telescope-emoji.nvim',

    -- Completion
     'neovim/nvim-lspconfig',
     'hrsh7th/nvim-cmp',
     'hrsh7th/cmp-buffer',
     {
        'L3MON4D3/LuaSnip',
        -- dependencies = {
        --     'rafamadriz/friendly-snippets'
        -- }
    },
     'saadparwaiz1/cmp_luasnip',
     'hrsh7th/cmp-nvim-lsp',
     {
        'ray-x/lsp_signature.nvim',
        config = function() require('lsp_signature').setup() end,
    },
     {
        'j-hui/fidget.nvim',
        config = function() require('fidget').setup() end,
    },
     'simrat39/rust-tools.nvim',
     'jose-elias-alvarez/typescript.nvim',
     'p00f/clangd_extensions.nvim',

    -- Tree-sitter
     {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},
     'nvim-treesitter/nvim-treesitter-textobjects',
     {'nvim-treesitter/playground', cmd = "TSPlaygroundToggle"},
     'nvim-treesitter/nvim-treesitter-context',

    -- Python
     'vimjas/vim-python-pep8-indent',
     'terrastruct/d2-vim',

})


require('options')
require('statusline')
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
            'yarn.lock',
            'compile_commands.json'
        },
    },
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')
require('telescope').load_extension('emoji')
require('styles')
require('tree')
