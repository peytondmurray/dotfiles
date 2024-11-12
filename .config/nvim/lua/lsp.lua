local nvim_lsp = require('lspconfig')
local configs = require("lspconfig.configs")
local luautils = require('luautils')
local cmp = require('cmp')
local snippy = require("snippy")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

local template = {
    sources = {
        vscode = {
            './friendly-snippets/snippets/'
        }
    },
    output = {
        snipmate = {
            vim.fn.stdpath('data') .. '/site/snippets',
        }
    }
}

require('snippet_converter').setup({
    templates = { template, }
})

cmp.setup{
    snippet = {
        expand = function(args)
            snippy.expand_snippet(args.body)
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
                elseif snippy.can_expand_or_advance() then
                    snippy.expand_or_advance()
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
                elseif snippy.can_jump(-1) then
                    snippy.previous()
                else
                    fallback()
                end
            end,
            {"i", "s"}
        )
    },
    sources = require('cmp').config.sources{
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'snippy' },
        { name = 'path' },
    },
}

if vim.fn.executable('ruff') == 1 then
    nvim_lsp['ruff'].setup({})
end
if vim.fn.executable('esbonio') == 1 then
    nvim_lsp['esbonio'].setup({})
end

nvim_lsp['stylelint_lsp'].setup({
    filetypes = { "css", "less", "scss", "sugarss", "wxss" }
})

nvim_lsp['bashls'].setup({
    capabilities = capabilities
})

-- When using clangd_extensions, you don't need to set up clangd
nvim_lsp['clangd'].setup({})
require('clangd_extensions').setup()

nvim_lsp['terraformls'].setup{
    capabilities = capabilities,
}

-- When using rust-tools, you don't need to set up rust-analyzer
require('rust-tools').setup()

if not configs.neocmake then
    configs.neocmake = {
        default_config = {
            cmd = { "neocmakelsp", "--stdio" },
            filetypes = { "cmake" },
            root_dir = function(fname)
                return nvim_lsp.util.find_git_ancestor(fname)
            end,
            single_file_support = true,-- suggested
        }
    }
    nvim_lsp.neocmake.setup({})
end

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'single' }
)
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {border = 'single'}
)

nvim_lsp['html'].setup({})
nvim_lsp['cssls'].setup({})
nvim_lsp['eslint'].setup{
    codeAction = {
        disableRuleComment = {
            enable = true,
            location = "separateLine"
        },
        showDocumentation = {
            enable = true
        }
    },
    codeActionOnSave = {
        enable = false,
        mode = "all"
    },
    format = true,
    nodePath = "",
    onIgnoredFiles = "off",
    packageManager = "yarn",
    quiet = false,
    rulesCustomizations = {},
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = {
        mode = "location"
    }
}

nvim_lsp['r_language_server'].setup({})

nvim_lsp['typst_lsp'].setup({})

nvim_lsp['ts_ls'].setup({})
