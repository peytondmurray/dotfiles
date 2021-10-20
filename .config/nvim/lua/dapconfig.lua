local dap = require('dap')

dap.adapters.lldb = {
    type = 'executable',
    command = 'lldb-vscode',
    name = 'lldb'
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

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require("dapui").setup()
