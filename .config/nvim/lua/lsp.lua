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
-- -- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
-- local user = vim.fn.expand('$USER')
-- local sumneko_root_path = "/home/" .. user .. "/.config/nvim/lua-language-server"
-- local sumneko_binary = "/home/" .. user .. "/.config/nvim/lua-language-server/bin/Linux/lua-language-server"
-- nvim_lsp['sumneko_lua'].setup {
--     cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
--     settings = {
--         Lua = {
--             runtime = {
--                 -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--                 version = 'LuaJIT',
--                 -- Setup your lua path
--                 path = vim.split(package.path, ';')
--             },
--             diagnostics = {
--                 -- Get the language server to recognize the `vim` global
--                 globals = {'vim', 'use'}
--             },
--             workspace = {
--                 -- Make the server aware of Neovim runtime files
--                 --library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true},
--                 library = vim.api.nvim_get_runtime_file('', true),
--                 maxPreload = 2000,
-- 	            preloadFileSize = 1000,
--             },
--             telemetry = {
--                 enable = false
--             }
--         }
--     }
-- }

nvim_lsp['tsserver'].setup{}

local eslint = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT} --rule 'prettier/prettier: false'",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintIgnoreExitCode = true,
    formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
}

local function eslint_config_exists()
    local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

    if not vim.tbl_isempty(eslintrc) then
        return true
    end

    if vim.fn.filereadable("package.json") then
        if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
            return true
        end
    end

    return false
end

nvim_lsp['efm'].setup{
    init_options = {documentFormatting = true},
    filetypes = {"javascript", "typescript"},
    root_dir = function()
        if not eslint_config_exists() then
            return nil
        end
        return vim.fn.getcwd()
    end,
    settings = {
        rootMarkers = {".eslintrc.js", ".git/"},
        languages = {
            javascript = {eslint},
            typescript = {eslint}
        }
    }
}

nvim_lsp['clangd'].setup{}

nvim_lsp['terraformls'].setup{}

nvim_lsp['rust_analyzer'].setup{}

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

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'single' }
)
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {border = 'single'}
)

--[[ vim.lsp.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = {
        spacing = 4,
        source = 'always',
        severity = {
            min = vim.lsp.diagnostic.severity.HINT,
        },
        format = function(diagnostic)
            if diagnostic.severity == vim.diagnostic.severity.ERROR then
                return string.format('E: %s', diagnostic.message)
            end
            return diagnostic.message
        end,
    },
    signs = true,
    severity_sort = true,
    float = {
        show_header = false,
        source = 'always',
        border = 'single',
    },
}) ]]
