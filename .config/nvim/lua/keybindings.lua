-- Keybindings
local opts = {noremap = true, silent = true}

local map = vim.keymap.set

-- Disable ex mode
map('n', 'Q', '<nop>', opts)
map('n', 'QQ', '<cmd>w<CR>', opts)
map('n', 'QW', '<cmd>wq<CR>', opts)
map('n', 'QE', '<cmd>q<CR>', opts)
map('n', 'QR', '<cmd>q!<CR>', opts)
map('n', 'QA', '<cmd>wa<CR>', opts)
map('n', 'QS', '<cmd>wqa<CR>', opts)
map('n', 'QD', '<cmd>qa<CR>', opts)
map('n', 'QF', '<cmd>qa!<CR>', opts)
map('n', 'q:', '<nop>', opts)

-- Set leader to spacebar
map('n', '<space>', '<nop>', opts)
vim.g.mapleader = ' '

-- Buffer motion
map('n', 'J', '30j', opts)
map('n', 'K', '30k', opts)
map('v', 'J', '30j', opts)
map('v', 'K', '30k', opts)

-- Window motion
map('n', '<C-J>', '<C-W><C-J>', opts)
map('n', '<C-K>', '<C-W><C-K>', opts)
map('n', '<C-L>', '<C-W><C-L>', opts)
map('n', '<C-H>', '<C-W><C-H>', opts)
map('n', '<M-C-J>', '<C-W>5-', opts)
map('n', '<M-C-K>', '<C-W>5+', opts)
map('n', '<M-C-L>', '<C-W>20>', opts)
map('n', '<M-C-H>', '<C-W>20<', opts)

-- Center view after various commands
map('n', 'gg', 'ggzz', opts)
map('n', 'G', 'Gzz', opts)
map('n', 'n', 'nzz', opts)
map('n', 'N', 'Nzz', opts)

-- Alt+. to repeat last macro
map('n', '<M-.>', '@@', opts)

-- ESC to get out of terminal mode
map('t', '<Esc>', [[<c-\><c-n>]], { noremap = true })

-- Ctrl+Backspace to delete word back
map('i', '<C-BS>', '<C-w>', opts)
map('i', '', '<C-w>', opts)

-- Tab/Shift+Tab to indent/dedent
map('i', '<S-Tab>', '<C-d>', opts)
map('v', '<S-Tab>', '<gv', opts)
map('v', '<Tab>', '>gv', opts)

-- Clear last search highlighting
map('n', '<M-/>', ':noh<CR>', opts)

-- Quickfix list movement
map('n', '<C-S-J>', '<cmd>cnext<CR>', opts)
map('n', '<C-S-K>', '<cmd>cprev<CR>', opts)

-- Telescope
map('n', '<leader>p', '<cmd>Telescope find_files<cr>', opts)
map('n', '<leader>;', function() return require("telescope").extensions.live_grep_args.live_grep_args() end, opts)
map('n', '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<CR>', opts)
map('n', '<leader>)', '<cmd>Telescope emoji<CR>', opts)

-- Pydocstring
local function docstring(args)
    require('neogen').generate(args)
end

map("n", "<Leader>dg",  docstring, opts)
map("n", "<Leader>don", function() docstring({ annotation_convention = { python = 'numpydoc' }}) end, opts)
map("n", "<Leader>dog", function() docstring({ annotation_convention = { python = 'google_docstrings' }}) end, opts)

-- LSP
map('n', '<leader>e', vim.lsp.buf.definition, opts)
map('n', '<leader>v', function() vim.cmd('vsplit'); vim.lsp.buf.definition() end, opts)
map('n', '<leader>s', function() vim.cmd('split'); vim.lsp.buf.definition() end, opts)
map('n', '<leader>E', vim.lsp.buf.declaration, opts)
map('n', '<leader>o', vim.lsp.buf.type_definition, opts)
map('n', '<leader>y', function() vim.cmd('TypescriptGoToSourceDefinition') end, opts)
map('n', '<leader>i', vim.lsp.buf.hover, opts)
map('n', '<leader>n', vim.lsp.buf.rename, opts)
map('n', '<leader>k', vim.diagnostic.goto_prev, opts)
map('n', '<leader>j', vim.diagnostic.goto_next, opts)
map('n', '<leader>h', vim.lsp.buf.code_action, opts)
map('n', '<leader>u', vim.lsp.buf.signature_help, opts)
map('n', '<leader>g', function() vim.cmd('ClangdSwitchSourceHeader') end, opts)
map('n', '<leader>f', vim.diagnostic.open_float, opts)
map('n', '<leader>l', vim.lsp.buf.references, opts)

-- Unused keybindings
-- map('n', '<leader>l', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
-- map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- map('n', '<leader>o', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
-- map('n', '<leader>y', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
-- map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

-- EasyAlign
map("x", "<leader>a", "<Plug>(EasyAlign)", {silent = true})
map("n", "<leader>a", "<Plug>(EasyAlign)", {silent = true})

-- Kommentary
map('n', '<leader>c', function() require('Comment.api').toggle.linewise.current() end, {silent = true})
map("x", "<leader>c", function() vim.api.nvim_feedkeys('', 'nx', false); require('Comment.api').toggle.linewise(vim.fn.visualmode()) end, {silent = true})

-- Symbols outline
map('n', '<leader>m', '<cmd>SymbolsOutline<CR>', opts)

-- NvimTree
map('n', '<leader>z', '<cmd>NvimTreeToggle<CR>', opts)

-- Debugger
map('n', '<F5>', '<cmd>lua require"dap".continue()<CR>', opts)
map('n', '<F6>', '<cmd>lua require"dap".step_over()<CR>', opts)
map('n', '<F7>', '<cmd>lua require"dap".step_into()<CR>', opts)
map('n', '<F8>', '<cmd>lua require"dap".step_out()<CR>', opts)
map('n', '<F9>', '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
map('n', '<F10>', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
map('n', '<F11>', '<cmd>lua require"dap".repl.open()<CR>', opts)
map('n', '<F12>', '<cmd>lua require("dapui").toggle()<CR>=', opts)
-- map('n', '<leader>dl', '<cmd>lua require"dap".repl.run_last()<CR>', opts)
-- map('n', '<leader>dsbm', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', opts)

-- Set filetype to terminal
map('n', '<leader>t', '<cmd>setl filetype=terminal<CR>', opts)

-- Fugitive
map('n', '<leader>rr', '<cmd>DiffviewOpen<CR>', opts)
map('n', '<leader>rl', '<cmd>0Gclog<CR>', opts)
