local nvim_lsp = require('lspconfig')
local luasnip = require('luasnip')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local cmp = require('cmp')
cmp.setup{
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    },
    sources = require('cmp').config.sources{
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
    },
}


-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--     properties = {
--         'documentation',
--         'detail',
--         'additionalTextEdits',
--     }
-- }

nvim_lsp['pylsp'].setup{
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150
    }
}


nvim_lsp['tsserver'].setup{
    capabilities = capabilities,
}

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
    },
    capabilities = capabilities,
}

nvim_lsp['clangd'].setup{
    capabilities = capabilities,
}

nvim_lsp['terraformls'].setup{
    capabilities = capabilities,
}

nvim_lsp['rust_analyzer'].setup{
    capabilities = capabilities,
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
