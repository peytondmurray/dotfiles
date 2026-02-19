local capabilities = require('blink.cmp').get_lsp_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

-- local function pixi_toml_exists(fname)
--    local f=io.open(fname, "r")
--    if f~=nil then io.close(f) return true else return false end
-- end

-- If you open nvim in a directory that contains pixi.toml or pixi.lock, use pixi to start
-- pylsp/ruff
local function get_python_lsp_command(...)
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
vim.lsp.config('gopls', {
    settings = {
        gopls = {
            analyses = {
                unusedvariable = false,
            }
        }
    }
})

vim.lsp.config('lua_ls', {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath('config')
                and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using (most
                -- likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Tell the language server how to find Lua modules same way as Neovim
                -- (see `:h lua-module-load`)
                path = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    -- Depending on the usage, you might want to add additional paths
                    -- here.
                    -- '${3rd}/luv/library',
                    -- '${3rd}/busted/library',
                },
                -- Or pull in all of 'runtimepath'.
                -- NOTE: this is a lot slower and will cause issues when working on
                -- your own configuration.
                -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                -- library = vim.api.nvim_get_runtime_file('', true),
            },
        })
    end,
    settings = {
        Lua = {},
    },
})

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
vim.lsp.enable('lua_ls')
