local dap = require('dap')

dap.adapters.codelldb = {
    type = 'executable',
    command = 'codelldb',
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

prev_function_node = nil
prev_function_name = ""

-- < Retrieve the name of the function the cursor is in.
function function_surrounding_cursor()
    local ts_utils = require('nvim-treesitter.ts_utils')
    local current_node = ts_utils.get_node_at_cursor()

    if not current_node then
        return ""
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
        return ""
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

dap.configurations.rust = {
    {
        name = "Test current function",
        type = "codelldb",
        request = "launch",
        program = "cargo",
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {"test", function_surrounding_cursor()},
        runInTerminal = false,
    },
}

dap.configurations.c = dap.configurations.cpp

require("dapui").setup()
