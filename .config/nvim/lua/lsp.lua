local nvim_lsp = require('lspconfig')
local luasnip = require('luasnip')
local luautils = require('luautils')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

-- require('ufo').setup()
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
            select = false,
        },
        ['<Tab>'] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif luautils.has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end,
            {"i", "s"}
        ),
        ['<S-Tab>'] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end,
            {"i", "s"}
        )
    },
    sources = require('cmp').config.sources{
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
    },
}


nvim_lsp['pylsp'].setup{
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150
    },
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = { enabled = false },
                mccabe = { enabled = false },
                pyflakes = { enabled = false },
                flake8 = { enabled = true },
            },
            configurationSources = { 'flake8' },
        }
    },
    cmd = {
        "pylsp", "-vv"
    }
}

-- nvim_lsp['tsserver'].setup{
--     capabilities = capabilities,
-- }
require('typescript').setup({
    server = {
        capabilities = capabilities
    }
})

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
        rootMarkers = {".eslintrc.*", ".git/"},
        languages = {
            javascript = {eslint},
            typescript = {eslint},
            typescriptreact = {eslint},
        }
    },
    capabilities = capabilities,
}

-- When using clangd_extensions, you don't need to set up rust-analyzer
require('clangd_extensions').setup()

nvim_lsp['terraformls'].setup{
    capabilities = capabilities,
}

-- When using rust-tools, you don't need to set up rust-analyzer
require('rust-tools').setup()


nvim_lsp['cmake'].setup{
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
