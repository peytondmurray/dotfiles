-- Keybindings
local opts = {noremap = true, silent = true}

-- Set leader to spacebar
vim.api.nvim_set_keymap('n', '<space>', '<nop>', opts)
vim.g.mapleader = ' '

-- Buffer motion
vim.api.nvim_set_keymap('n', 'J', '30j', opts)
vim.api.nvim_set_keymap('n', 'K', '30k', opts)
vim.api.nvim_set_keymap('v', 'J', '30j', opts)
vim.api.nvim_set_keymap('v', 'K', '30k', opts)

-- Window motion
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', opts)
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', opts)
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', opts)
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', opts)

vim.api.nvim_set_keymap('n', '<M-C-J>', '<C-W>20-', opts)
vim.api.nvim_set_keymap('n', '<M-C-K>', '<C-W>20+', opts)
vim.api.nvim_set_keymap('n', '<M-C-L>', '<C-W>20>', opts)
vim.api.nvim_set_keymap('n', '<M-C-H>', '<C-W>20<', opts)

-- Alt+. to repeat last macro
vim.api.nvim_set_keymap('n', '<M-.>', '@@', opts)

-- ESC to get out of terminal mode
vim.api.nvim_set_keymap('t', '<Esc>', [[<c-\><c-n>]], { noremap = true })

-- Ctrl+Backspace to delete word back
vim.api.nvim_set_keymap('i', '<C-BS>', '<C-w>', opts)
vim.api.nvim_set_keymap('i', '', '<C-w>', opts)

-- Tab/Shift+Tab to indent/dedent
vim.api.nvim_set_keymap('i', '<S-Tab>', '<C-d>', opts)
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', opts)
vim.api.nvim_set_keymap('v', '<Tab>', '>gv', opts)

-- Move line up/down
vim.api.nvim_set_keymap('n', '<M-j>', '<cmd>m+1<CR>', opts)
vim.api.nvim_set_keymap('n', '<M-k>', '<cmd>m-2<CR>', opts)

-- Clear last search highlighting
vim.api.nvim_set_keymap('n', '<M-/>', ':noh<CR>', opts)

-- Telescope
vim.api.nvim_set_keymap('n', '<leader>p', '<cmd>Telescope find_files<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>;', '<cmd>Telescope live_grep<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<CR>', opts)

-- Pydocstring
vim.api.nvim_set_keymap('n', '<leader>d', '<Plug>(pydocstring)', opts)

-- LSP keybinds
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>v', '<cmd>vs<cr><cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>s', '<cmd>sp<cr><cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>i', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>n', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>j', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--vim.api.nvim_set_keymap('n', '<leader>l', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>h', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

-- Lua
vim.api.nvim_set_keymap("n", "<leader>ll", "<cmd>Trouble<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>lw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>ld", "<cmd>Trouble lsp_document_diagnostics<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>lt", "<cmd>Trouble loclist<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>lq", "<cmd>Trouble quickfix<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>lr", "<cmd>Trouble lsp_references<cr>", opts)

-- vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>u', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>o', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>y', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
-- vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

-- Navigate around completion popup
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.expand_cr()', {expr = true})

-- EasyAlign
vim.api.nvim_set_keymap("x", "<leader>a", "<Plug>(EasyAlign)", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>a", "<Plug>(EasyAlign)", {silent = true})

-- Kommentary
vim.api.nvim_set_keymap('n', '<leader>c', '<Plug>kommentary_line_default', {silent = true})
vim.api.nvim_set_keymap("x", "<leader>c", "<Plug>kommentary_visual_default", {silent = true})

-- Symbols outline
vim.api.nvim_set_keymap('n', '<leader>m', '<cmd>SymbolsOutline<CR>', opts)

-- NvimTree
vim.api.nvim_set_keymap('n', '<leader>z', '<cmd>NvimTreeToggle<CR>', opts)
