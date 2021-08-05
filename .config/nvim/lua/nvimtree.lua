local tree_cb = require('nvim-tree.config').nvim_tree_callback
vim.g.nvim_tree_bindings = {
    { key = {'<CR>', 'e'},                  cb = tree_cb('edit') },
    { key = 'l',                            cb = tree_cb('cd') },
    { key = 'v',                            cb = tree_cb('vsplit') },
    { key = 's',                            cb = tree_cb('split') },
    { key = 't',                            cb = tree_cb('tabnew') },
    { key = 'h',                            cb = tree_cb('dir_up') },
}
