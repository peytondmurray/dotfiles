require('packer').startup(function()

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
    use {'folke/which-key.nvim', config = require('which-key').setup{} }

    -- Symbols browser
    use 'simrat39/symbols-outline.nvim'

    -- Indent guides
    use 'lukas-reineke/indent-blankline.nvim'

    -- User-defined text objects
    use 'kana/vim-textobj-user'

    -- Neovim in the browser
    use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

    -- Window motions: windows can be yanked/pasted
    use 'wesq3/vim-windowswap'

    -- Colorschemes
    use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

    -- Colorize hex codes
    use 'norcalli/nvim-colorizer.lua'

    -- Git Integration
    use 'airblade/vim-gitgutter'
    use 'tpope/vim-fugitive'

    -- Telescope----
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    -- Completion
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'
    use 'hrsh7th/nvim-compe'
    use 'L3MON4D3/LuaSnip'
    use "rafamadriz/friendly-snippets"

    -- Tree-sitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/playground'
end)

-- Use spaces instead of tabs
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.smarttab = true

vim.o.termguicolors = true

-- Diagnostic messaging
vim.o.signcolumn = 'yes'

-- Case sensitive searching only when caps used
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "nosplit"
vim.o.incsearch = true

vim.o.number = true
vim.o.cursorline = true
vim.o.autoread = true
vim.o.wrap = false

vim.o.splitbelow = true
vim.o.splitright = true

-- Remove ~ at end of buffer
vim.o.fillchars = 'eob: '

vim.cmd('highlight Vertsplit guifg=Orange')
vim.cmd('highlight illuminatedWord ctermbg=4 guibg=#233551')
vim.cmd('filetype plugin indent on')

-- Keybindings
local opts = {noremap = true, silent = true}

-- Set leader to spacebar
vim.api.nvim_set_keymap('n', '<space>', '<nop>', opts)
vim.g.mapleader = ' '

-- Buffer motion
vim.api.nvim_set_keymap('n', 'J', '30j', opts)
vim.api.nvim_set_keymap('n', 'K', '30k', opts)
vim.api.nvim_set_keymap('v', 'J', '30j', opts)
vim.api.nvim_set_keymap('v', 'K', '30k', opts)

-- Window motion
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', opts)
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', opts)
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', opts)
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', opts)

vim.api.nvim_set_keymap('n', '<M-C-J>', '<C-W>20-', opts)
vim.api.nvim_set_keymap('n', '<M-C-K>', '<C-W>20+', opts)
vim.api.nvim_set_keymap('n', '<M-C-L>', '<C-W>20>', opts)
vim.api.nvim_set_keymap('n', '<M-C-H>', '<C-W>20<', opts)

-- Alt+. to repeat last macro
vim.api.nvim_set_keymap('n', '<M-.>', '@@', opts)

-- ESC to get out of terminal mode
vim.api.nvim_set_keymap('t', '<Esc>', [[<c-\><c-n>]], { noremap = true })

-- Ctrl+Backspace to delete word back
vim.api.nvim_set_keymap('i', '<C-BS>', '<C-w>', opts)
vim.api.nvim_set_keymap('i', '', '<C-w>', opts)

-- Tab/Shift+Tab to indent/dedent
vim.api.nvim_set_keymap('i', '<S-Tab>', '<C-d>', opts)
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', opts)
vim.api.nvim_set_keymap('v', '<Tab>', '>gv', opts)

-- Move line up/down
vim.api.nvim_set_keymap('n', '<M-j>', '<cmd>m+1<CR>', opts)
vim.api.nvim_set_keymap('n', '<M-k>', '<cmd>m-2<CR>', opts)

-- Clear last search highlighting
vim.api.nvim_set_keymap('n', '<M-/>', ':noh<CR>', opts)

-- Telescope
vim.api.nvim_set_keymap('n', '<leader>p', '<cmd>Telescope find_files<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>;', '<cmd>Telescope live_grep<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<CR>', opts)

-- Strip trailing whitespace on save; remove blank line at end of file
StripWhitespace = function()
    vim.cmd('%s/\\s\\+$//e')
    vim.cmd('%s/\\($\\n\\s*\\)\\+\\%$//e')
end
vim.cmd([[autocmd BufWritePre * lua StripWhitespace()]])

-- Gitgutter
vim.g.SignatureMarkTextHLDynamic = 1

-- Use numpydoc docstrings
vim.g.pydocstring_formatter = 'numpy'
vim.g.pydocstring_doq_path = '~/.pyenv/shims/doq'
vim.api.nvim_set_keymap('n', '<leader>d', '<Plug>(pydocstring)', opts)

-- Start Telescope
require('telescope').setup{
    colorscheme = {
        enable_preview = true,
    }
}

local tc = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.o.background = "dark" -- or "light" for light mode
vim.cmd('colorscheme gruvbox')

vim.o.foldmethod = 'expr'
vim.o.foldexpr = vim.fn['nvim_treesitter#foldexpr']()
vim.o.foldenable = false

require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
    },
    indent = {
        enable = true
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
    },
}


local nvim_lsp = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

-- LSP keybinds
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>v', '<cmd>vs<cr><cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>s', '<cmd>sp<cr><cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>i', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>n', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>j', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>l', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>h', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

-- vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>u', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>o', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>y', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
-- vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

nvim_lsp["pylsp"].setup {
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150
    },
    cmd = { 'pylsp' },
    settings = {
        configurationSources = {'flake8'},
        plugins = {
            flake8 = {
                enabled = true
            },
            pydocstyle = {
                enabled = false
            }
        }
    }
}
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
USER = vim.fn.expand('$USER')
local sumneko_root_path = "/home/" .. USER .. "/.config/nvim/lua-language-server"
local sumneko_binary = "/home/" .. USER .. "/.config/nvim/lua-language-server/bin/Linux/lua-language-server"
nvim_lsp['sumneko_lua'].setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim', 'use'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                --library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true},
                library = vim.api.nvim_get_runtime_file('', true),
                maxPreload = 2000,
	            preloadFileSize = 1000,
            },
            telemetry = {
                enable = false
            }
        }
    }
}

require('compe').setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
        path = true;
        buffer = true;
        nvim_lsp = true;
        ultisnips = true;
        luasnip = true;
    };
}

-- Load snippets given by friendly-snippets
require('luasnip/loaders/from_vscode').lazy_load()

-- Check whether the prior character is whitespace
local is_prior_char_whitespace = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (shift-)tab to:
--- move to prev/next item in completion/snippet menu
--- insert a simple tab
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return tc('<C-n>')
    elseif require('luasnip').expand_or_jumpable() then
        return tc('<cmd>lua require("luasnip").jump(1)<CR>')
    elseif is_prior_char_whitespace() then
        return tc('<Tab>')
    else
        return vim.fn['compe#complete']()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return tc('<C-p>')
    elseif require('luasnip').jumpable(-1) then
        return tc('<cmd>lua require("luasnip").jump(-1)<CR>')
    else
        return tc('<S-Tab>')
    end
end

-- Use <CR> to:
-- expand a snippet
-- insert a simple tab
_G.expand_cr = function()
    if require('luasnip').expand_or_jumpable() then
        return tc('<Plug>luasnip-expand-or-jump')
    end
    return tc('<CR>')
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.expand_cr()', {expr = true})

-- Show completion menu even if only one option is available; don't select by default
vim.o.completeopt = 'menuone,noselect'

-- Gdiffsplit opens vertically
vim.o.diffopt = vim.o.diffopt .. ',vertical'

-- Set EasyAlign hotkeys
vim.api.nvim_set_keymap("x", "<leader>a", "<Plug>(EasyAlign)", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>a", "<Plug>(EasyAlign)", {silent = true})

vim.g.indentLine_char = '|'
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.shortmess = 'I'

-- which-key
vim.o.timeoutlen = 500

-- Popups have pseudotransparency
vim.o.wildoptions='pum'
vim.o.pumblend = 20
vim.o.winblend = 20

-- Firenvim
vim.g.firenvim_config = {
    globalSettings = {alt = 'all'},
    localSettings = {
        ['.*'] = {
            cmdline = 'neovim',
            content = 'text',
            priority = 0,
            selector = 'textarea',
            takeover = 'never',
        },
    }
}

-- Kommentary
vim.g.kommentary_create_default_mappings = false
require('kommentary.config').configure_language(
    "default",
    {prefer_single_line_comments = true}
)
vim.api.nvim_set_keymap('n', '<leader>c', '<Plug>kommentary_line_default', {silent = true})
vim.api.nvim_set_keymap("x", "<leader>c", "<Plug>kommentary_visual_default", {silent = true})

-- Set up colorizer; must be done after termguicolors is set
require('colorizer').setup()

-- NvimTree Settings
vim.api.nvim_set_keymap('n', '<leader>z', '<cmd>NvimTreeToggle<CR>', opts)
local tree_cb = require('nvim-tree.config').nvim_tree_callback
vim.g.nvim_tree_bindings = {
    { key = {"<CR>", "e"},                  cb = tree_cb("edit") },
    { key = 'l',                            cb = tree_cb("cd") },
    { key = "v",                            cb = tree_cb("vsplit") },
    { key = "s",                            cb = tree_cb("split") },
    { key = "t",                            cb = tree_cb("tabnew") },
    { key = "h",                            cb = tree_cb("dir_up") },
}
vim.g.nvim_tree_ignore = {
    '.git',
    'node_modules',
    '.cache',
    '__pycache__',
    '.pytest_cache',
    '.mypy_cache',
    '.ipynb_checkpoints',
}

-- Symbols outline
vim.api.nvim_set_keymap('n', '<leader>x', '<cmd>SymbolsOutline<CR>', opts)
