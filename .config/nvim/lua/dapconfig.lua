local dap = require('dap')

-- Setup the adapter
dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "node",
        args = { "/usr/lib/js-debug/dapDebugServer.js" , "${port}" },
    },
}

-- Alias "node" to "pwa-node"
dap.adapters["node"] = function(cb, config)
    if config.type == "node" then
        config.type = "pwa-node"
    end
    local a = dap.adapters["pwa-node"]
    if type(a) == "function" then
        a(cb, config)
    else
        cb(a)
    end
end

-- Debug configurations for JS/TS
local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
for _, ft in ipairs(js_filetypes) do
    dap.configurations[ft] = {
        -- Attach to running Node.js process
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach to Node.js",
            port = 9229,
            address = "localhost",
            localRoot = vim.fn.getcwd(),
            remoteRoot = "/usr/src/app",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = "inspector",
        },
        -- Debug Mocha tests
        {
            type = "pwa-node",
            request = "launch",
            name = "Debug Mocha Tests",
            program = "${workspaceFolder}/node_modules/mocha/bin/_mocha",
            args = {
                "--require",
                "ts-node/register/transpile-only",
                "--require",
                "source-map-support/register",
                "--reporter",
                "spec",
                "--colors",
                "${workspaceFolder}/tests/unit/**/*.[tj]s",
            },
            cwd = vim.fn.getcwd(),
            runtimeExecutable = "node",
            internalConsoleOptions = "openOnSessionStart",
            skipFiles = { "<node_internals>/**" },
            sourceMaps = true,
            protocol = "inspector",
        },
        -- Debug Jest tests
        {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Tests",
            program = "${workspaceFolder}/node_modules/jest/bin/jest.js",
            args = { "--runInBand", "--no-cache", "${relativeFile}" },
            cwd = "${workspaceFolder}",
            runtimeExecutable = "node",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
        },
        -- Debug Vitest tests
        {
            type = "pwa-node",
            request = "launch",
            name = "Debug Vitest Tests",
            program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
            args = { "run", "${relativeFile}" },
            cwd = "${workspaceFolder}",
            runtimeExecutable = "node",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
            autoAttachChildProcesses = true,
        },
    }
end

dap.adapters.codelldb = {
    type = 'executable',
    command = 'codelldb',
    name = 'lldb',
    -- initCommands = {"command source ${env:HOME}/.lldbinit"},
    -- preRunCommands = {
    --     "command script import ~/.config/rust_prettifier_for_lldb.py"
    -- }
}

vim.fn.sign_define(
    "DapBreakpoint",
    { text = "🛑", texthl = "", linehl = "", numhl = "" }
)
vim.fn.sign_define(
    "DapStopped",
    { text = "🟢", texthl = "", linehl = "", numhl = "" }
)

dap.configurations.cpp = {
    {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input(
                "Path to executable: ",
                vim.fn.getcwd() .. "/build/" .. vim.fn.expand('%:t:r'),
                "file"
            )
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
    },
}

prev_function_node = nil
prev_function_name = ""

-- < Retrieve the name of the function the cursor is in.
function _G.function_surrounding_cursor()
    local ts_utils = require('nvim-treesitter.ts_utils')
    local current_node = ts_utils.get_node_at_cursor()

    if not current_node then
        return "not current node"
    end

    local func = current_node

    while func do
        if func:type() == 'function_definition' then
            break
        end

        func = func:parent()
    end

    if not func then
        prev_function_node = nil
        prev_function_name = ""
        return "not a function"
    end

    if func == prev_function_node then
        return prev_function_name
    end

    prev_function_node = func

    local find_name
    find_name = function(node)
        for i = 0, node:named_child_count() - 1, 1 do
            local child = node:named_child(i)
            local type = child:type()

            if type == 'identifier' or type == 'operator_name' then
                return (ts_utils.get_node_text(child))[1]
            else
                local name = find_name(child)

                if name then
                    return name
                end
            end
        end

        return nil
    end

    prev_function_name = find_name(func)
    return prev_function_name
end

-- dap.configurations.rust = {
--     {
--         name = "Test current function",
--         type = "codelldb",
--         request = "launch",
--         program = "cargo",
--         cwd = "${workspaceFolder}",
--         stopOnEntry = false,
--         args = {"test", function_surrounding_cursor()},
--         runInTerminal = false,
--     },
-- }


local function rust_detect_bin()
    local name = vim.fn.trim(
        vim.fn.system(
            "cargo metadata --format-version 1 --no-deps | jq -r '.packages[0].name'"
        )
    )
  return vim.fn.getcwd() .. "/target/debug/" .. name
end

dap.configurations.rust = {
    {
        name = "Debug current binary (with args)",
        type = "codelldb",
        request = "launch",
        program = rust_detect_bin,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
            local input = vim.fn.input('Args: ')

            -- Split the input on spaces into table
            if input == '' then
                return {}
            end
            return vim.split(input, ' ', { trimempty = true })
        end,
    },
}

dap.configurations.c = dap.configurations.cpp

require("dapui").setup()
