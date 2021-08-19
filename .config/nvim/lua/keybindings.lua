-- Keybindings
local opts = {noremap = true, silent = true}

local map = vim.api.nvim_set_keymap

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

map('n', '<M-C-J>', '<C-W>20-', opts)
map('n', '<M-C-K>', '<C-W>20+', opts)
map('n', '<M-C-L>', '<C-W>20>', opts)
map('n', '<M-C-H>', '<C-W>20<', opts)

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

-- Move line up/down
map('n', '<M-j>', '<cmd>m+1<CR>', opts)
map('n', '<M-k>', '<cmd>m-2<CR>', opts)

-- Clear last search highlighting
map('n', '<M-/>', ':noh<CR>', opts)

-- Telescope
map('n', '<leader>p', '<cmd>Telescope find_files<cr>', opts)
map('n', '<leader>;', '<cmd>Telescope live_grep<CR>', opts)
map('n', '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<CR>', opts)

-- Pydocstring
map('n', '<leader>dd', '<cmd>Pydocstring<CR>', opts)
map('n', '<leader>df', '<cmd>PydocstringFormat<CR>', opts)
map('n', '<leader>do', '<cmd>DogeGenerate<CR>', opts)

-- LSP
map('n', '<leader>e', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
map('n', '<leader>v', '<cmd>vs<cr><cmd>lua vim.lsp.buf.definition()<CR>', opts)
map('n', '<leader>s', '<cmd>sp<cr><cmd>lua vim.lsp.buf.definition()<CR>', opts)
-- map('n', '<leader>i', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- map('n', '<leader>n', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- map('n', '<leader>k', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
-- map('n', '<leader>j', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
-- --map('n', '<leader>l', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
-- map('n', '<leader>h', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

-- Unused keybindings
-- map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- map('n', '<leader>u', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- map('n', '<leader>o', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
-- map('n', '<leader>y', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
-- map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

-- LSP Saga
map('n', '<leader>h', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts)
map('v', '<leader>h', "<cmd>lua require('lspsaga.codeaction').range_code_action()<CR>", opts)
map('n', '<leader>I', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
map('n', '<leader>i', "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", opts)
map('n', '<leader>n', "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
map('n', '<leader>k', "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<CR>", opts)
map('n', '<leader>j', "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<CR>", opts)

-- Lua
map("n", "<leader>ll", "<cmd>Trouble<cr>", opts)
map("n", "<leader>lw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", opts)
map("n", "<leader>ld", "<cmd>Trouble lsp_document_diagnostics<cr>", opts)
map("n", "<leader>lt", "<cmd>Trouble loclist<cr>", opts)
map("n", "<leader>lq", "<cmd>Trouble quickfix<cr>", opts)
map("n", "<leader>lr", "<cmd>Trouble lsp_references<cr>", opts)

-- Navigate around completion popup
map('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
map('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
map('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
map('i', '<CR>', 'v:lua.expand_cr()', {expr = true})

-- EasyAlign
map("x", "<leader>a", "<Plug>(EasyAlign)", {silent = true})
map("n", "<leader>a", "<Plug>(EasyAlign)", {silent = true})

-- Kommentary
map('n', '<leader>c', '<Plug>kommentary_line_default', {silent = true})
map("x", "<leader>c", "<Plug>kommentary_visual_default", {silent = true})

-- Symbols outline
map('n', '<leader>m', '<cmd>SymbolsOutline<CR>', opts)

-- NvimTree
map('n', '<leader>z', '<cmd>NvimTreeToggle<CR>', opts)
