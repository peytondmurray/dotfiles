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
local user = vim.fn.expand('$USER')
local sumneko_root_path = "/home/" .. user .. "/.config/nvim/lua-language-server"
local sumneko_binary = "/home/" .. user .. "/.config/nvim/lua-language-server/bin/Linux/lua-language-server"
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

nvim_lsp['tsserver'].setup{}

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
