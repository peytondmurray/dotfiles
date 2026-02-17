local capabilities = require('blink.cmp').get_lsp_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

function pixi_toml_exists(fname)
   local f=io.open(fname, "r")
   if f~=nil then io.close(f) return true else return false end
end

-- If you open nvim in a directory that contains pixi.toml or pixi.lock, use pixi to start
-- pylsp/ruff
function get_python_lsp_command(...)
    local arg = {...}
    -- if pixi_toml_exists("pixi.toml") or pixi_toml_exists("pixi.lock") then
    --     return {'pixi', 'run', unpack(arg)}
    -- else
    --     return arg
    -- end
    return arg
end

vim.lsp.config('pylsp', {
    cmd = get_python_lsp_command('pylsp'),
    settings = {
        pylsp = {
            plugins = {
                pyflakes = {
                    enabled = false
                },
                pycodestyle = {
                    enabled = false
                },
                autopep8 = {
                    enabled = false
                },
                flake8 = {
                    enabled = false
                }
            }
        }
    }
})
vim.lsp.config('ruff', {
    cmd = get_python_lsp_command('ruff', 'server')
})
vim.lsp.config('stylelint_lsp', {
    filetypes = { "css", "less", "scss", "sugarss", "wxss" }
})
vim.lsp.config('bashls', {
    capabilities = capabilities
})
vim.lsp.config('terraformls', {
    capabilities = capabilities,
    default_config = {
        cmd = { "neocmakelsp", "--stdio" },
        filetypes = { "cmake" },
        root_dir = function(fname)
            return nvim_lsp.util.find_git_ancestor(fname)
        end,
        single_file_support = true,-- suggested
    }
})
vim.lsp.config('gopls', {
    settings = {
        gopls = {
            analyses = {
                unusedvariable = false,
            }
        }
    }
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'single' }
)
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {border = 'single'}
)

vim.lsp.enable('neocmake')
vim.lsp.enable('pylsp')
vim.lsp.enable('html')
vim.lsp.enable('cssls')
vim.lsp.enable('r_language_server')
vim.lsp.enable('tinymist')
vim.lsp.enable('ts_ls')
vim.lsp.enable('gdscript')
vim.lsp.enable('gdshader_lsp')
vim.lsp.enable('gh_actions_ls')
vim.lsp.enable('ruff')
vim.lsp.enable('biome')
vim.lsp.enable('gopls')
vim.lsp.enable('golangci_lint_ls')
vim.lsp.enable('esbonio')
vim.lsp.enable('fortls')
vim.lsp.enable('clangd')

-- -- Workaround for rust-analyzer bug
-- -- https://github.com/neovim/neovim/issues/30985#issuecomment-2447329525
-- for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
--     local default_diagnostic_handler = vim.lsp.handlers[method]
--     vim.lsp.handlers[method] = function(err, result, context, config)
--         if err ~= nil and err.code == -32802 then
--             return
--         end
--         return default_diagnostic_handler(err, result, context, config)
--     end
-- end
