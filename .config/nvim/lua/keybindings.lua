-- Keybindings
local opts = {noremap = true, silent = true}

local function map(mode, lhs, rhs, options, desc)
    local new_opts = {}
    if options then
        new_opts = vim.tbl_extend("force", new_opts, options)
        if desc then
            new_opts["desc"] = desc
        end
    end
    vim.keymap.set(mode, lhs, rhs, new_opts)
end

-- Disable ex mode
map('n', 'gQ', '<nop>', opts)

-- Bind Q operations to file save/save all/quit
map('n', 'Q', '<nop>', opts)
map('n', 'QQ', '<cmd>w<CR>', opts, "save the current buffer (:w)")
map('n', 'QW', '<cmd>wq<CR>', opts, "save and close the current buffer (:wq)")
map('n', 'QE', '<cmd>q<CR>', opts, "close the buffer (:q)")
map('n', 'QR', '<cmd>q!<CR>', opts, "force close the buffer (:q!)")
map('n', 'QA', '<cmd>wa<CR>', opts, "save all buffers (:wa)")
map('n', 'QS', '<cmd>wqa<CR>', opts, "save and quite all buffers (:wqa)")
map('n', 'QD', '<cmd>qa<CR>', opts, "quit all buffers (:qa)")
map('n', 'QF', '<cmd>qa!<CR>', opts, "force quit all buffers (:qa!)")
map('n', 'q:', '<nop>', opts)

-- Set leader to spacebar
map('n', '<space>', '<nop>', opts, "leader")
vim.g.mapleader = ' '

-- Buffer motion. Set in a function so that it can be reset upon leaving venn mode
function set_n_JK()
    map('n', 'J', '30jzz', opts, "jump 30 lines down")
    map('n', 'K', '30kzz', opts, "jump 30 lines up")
end

set_n_JK()
map('v', 'J', '30j', opts, "jump 30 lines down")
map('v', 'K', '30k', opts, "jump 30 lines up")

-- Window motion
map('n', '<C-J>', '<C-W><C-J>', opts, "Move to the window below")
map('n', '<C-K>', '<C-W><C-K>', opts, "Move to the window above")
map('n', '<C-L>', '<C-W><C-L>', opts, "Move to the window right")
map('n', '<C-H>', '<C-W><C-H>', opts, "Move to the window left")
map('n', '<M-C-J>', '<C-W>5-', opts, "Decrease window height")
map('n', '<M-C-K>', '<C-W>5+', opts, "Increase window height")
map('n', '<M-C-L>', '<C-W>20>', opts, "Increase window width")
map('n', '<M-C-H>', '<C-W>20<', opts, "Decrease window width")

-- Center view after various commands
map('n', 'gg', 'ggzz', opts, "Go to top and center cursor")
map('n', 'G', 'Gzz', opts, "Go to bottom and center cursor")
map('n', 'n', 'nzz', opts, "Repeat search forward and center cursor")
map('n', 'N', 'Nzz', opts, "Repeat search backward and center cursor")

-- Alt+. to repeat last macro
map('n', '<M-.>', '@@', opts, "Repeat last played macro")

-- ESC to get out of terminal mode
map('t', '<Esc>', [[<c-\><c-n>]], { noremap = true }, "Exit terminal mode")

-- Ctrl+Backspace to delete word back
map('i', '<C-BS>', '<C-w>', opts, "Delete previous word")
map('i', '', '<C-w>', opts, "Delete previous word")

-- Tab/Shift+Tab to indent/dedent
map('i', '<S-Tab>', '<C-d>', opts, "Dedent")
map('v', '<S-Tab>', '<gv', opts, "Dedent selection")
map('v', '<Tab>', '>gv', opts, "Indent selection")

-- Clear last search highlighting
map('n', '<M-/>', ':noh<CR>', opts, "Clear last search highlight")

-- Quickfix list movement
map('n', '<C-S-J>', '<cmd>cnext<CR>', opts, "Jump to next quickfix item")
map('n', '<C-S-K>', '<cmd>cprev<CR>', opts, "Jump to previous quickfix item")

-- Remap <C-j>/<C-k> to move through options in completion menus
map('c', '<C-j>', function()
  return vim.fn.wildmenumode() > 0 and '<C-n>' or '<C-j>'
end, { expr = true, noremap = true })

map('c', '<C-k>', function()
  return vim.fn.wildmenumode() > 0 and '<C-p>' or '<C-k>'
end, { expr = true, noremap = true })

-- Telescope
map('n', '<leader>p', '<cmd>Telescope find_files<cr>', opts, "Find files")
map('n', '<leader>;', function() return require("telescope").extensions.live_grep_args.live_grep_args() end, opts, "Grep with arguments")
map('n', '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<CR>', opts, "Fuzzy find in buffer")
map('n', '<leader>)', '<cmd>Telescope emoji<CR>', opts, "Pick emoji")

-- Docstrings
local doc = require('neogen').generate
map("n", "<Leader>dg", function() doc({ annotation_convention = { python = 'numpydoc' }}) end, opts, "Generate docstring")
map("n", "<Leader>dor", function() doc({ annotation_convention = { python = 'reST' }}) end, opts, "Generate reST docstring")
map("n", "<Leader>dog", function() doc({ annotation_convention = { python = 'google_docstrings' }}) end, opts, "Generate Google docstring")
map("n", "<Leader>don", function() doc({ annotation_convention = { python = 'numpydoc' }}) end, opts, "Generate Numpydoc docstring")

-- LSP
map('n', '<leader>e', vim.lsp.buf.definition, opts, "Go to definition")
map('n', '<leader>v', function() vim.cmd('vsplit'); vim.lsp.buf.definition() end, opts, "Go to definition (vsplit)")
map('n', '<leader>s', function() vim.cmd('split'); vim.lsp.buf.definition() end, opts, "Go to definition (hsplit)")
map('n', '<leader>E', vim.lsp.buf.declaration, opts, "Go to declaration")
map('n', '<leader>o', vim.lsp.buf.type_definition, opts, "Go to type definition")
map('n', '<leader>i', vim.lsp.buf.hover, opts, "Show hover information")
map('n', '<leader>n', vim.lsp.buf.rename, opts, "Rename symbol")
map('n', '<leader>k', vim.diagnostic.goto_prev, opts, "Go to previous diagnostic")
map('n', '<leader>j', vim.diagnostic.goto_next, opts, "Go to next diagnostic")
map('n', '<leader>h', vim.lsp.buf.code_action, opts, "Show code actions")
map('n', '<leader>u', vim.lsp.buf.signature_help, opts, "Show signature help")
map('n', '<leader>g', function() vim.cmd('ClangdSwitchSourceHeader') end, opts, "Switch source/header (Clangd)")
map('n', '<leader>f', vim.diagnostic.open_float, opts, "Show diagnostic message")
map('n', '<leader>l', vim.lsp.buf.references, opts, "Show references")

-- Unused keybindings
-- map('n', '<leader>l', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
-- map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
-- map('n', '<leader>y', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
-- map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

-- EasyAlign
map("x", "<leader>a", "<Plug>(EasyAlign)", {silent = true}, "Align text")
map("n", "<leader>a", "<Plug>(EasyAlign)", {silent = true}, "Align text")

-- Symbols outline
map('n', '<leader>m', '<cmd>Outline<CR>', opts, "Toggle symbols outline")

-- NvimTree
map('n', '<leader>z', '<cmd>NvimTreeToggle<CR>', opts, "Toggle file tree")

-- Debugger
map('n', '<F5>', function() require'dap'.continue() end, opts, "Continue/start debug session")
map('n', '<F6>', function() require'dap'.step_over() end, opts, "Step over")
map('n', '<F7>', function() require'dap'.step_into() end, opts, "Step into")
map('n', '<F8>', function() require'dap'.step_out() end, opts, "Step out")
map('n', '<F9>', function() require'dap'.toggle_breakpoint() end, opts, "Toggle breakpoint")
map('n', '<F10>', function() require'dap'.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, opts, "Set conditional breakpoint")
map('n', '<F11>', function() require'dap'.repl.open() end, opts, "Open debug REPL")
map('n', '<F12>', function() require("dapui").toggle() end, opts, "Toggle DAP UI")

-- map('n', '<leader>dl', '<cmd>lua require"dap".repl.run_last()<CR>', opts)
-- map('n', '<leader>dsbm', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', opts)

-- Fugitive
map('n', '<leader>rr', '<cmd>DiffviewOpen<CR>', opts, "Open Diffview")
map('n', '<leader>rl', '<cmd>0Gclog<CR>', opts, "Show file commit history")

-- venn.nvim: enable or disable keymappings
function toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[set cursorcolumn]]
        vim.cmd[[setlocal ve=all]]

        -- draw a line on HJKL keystokes
        map("n", "J", "<C-v>j:VBox<CR>", opts, "Draw arrow down")
        map("n", "K", "<C-v>k:VBox<CR>", opts, "Draw arrow up")
        map("n", "L", "<C-v>l:VBox<CR>", opts, "Draw arrow right")
        map("n", "H", "<C-v>h:VBox<CR>", opts, "Draw arrow left")

        -- draw a box by pressing "f" with visual selection
        map("v", "f", ":VBox<CR>", opts, "Draw box")
    else
        vim.b.venn_enabled = nil
        vim.cmd[[set nocursorcolumn]]
        vim.cmd[[setlocal ve=]]
        set_n_JK()
        vim.keymap.del("n", "L")
        vim.keymap.del("n", "H")
        vim.keymap.del("v", "f")
    end
end
-- toggle keymappings for venn using <leader>v
map('n', '<leader>b', toggle_venn, opts, "Toggle venn diagram mode")

-- AI
map({'n', 'v'}, '<leader>tc', function() require('codecompanion').chat() end, opts, 'Open CodeCompanionChat')
map({'n', 'v'}, '<leader>ti', function() require('codecompanion').inline() end, opts, 'Run CodeCompanion inline')
