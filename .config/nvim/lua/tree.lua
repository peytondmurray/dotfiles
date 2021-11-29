local tree_cb  = require('nvim-tree.config').nvim_tree_callback
require('nvim-tree').setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    auto_close = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = false,
    update_to_buf_dir = {
        enable = true,
        auto_open = true,
    },
    diagnostics = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        }
    },
    update_focused_file = {
        enable = false,
        update_cwd = false,
        ignore_list = {}
    },
    system_open = {
        cmd = nil,
        args = {}
    },
    filters = {
        dotfiles = false,
        custom = {
            '.git',
            'node_modules',
            '.cache',
            '__pycache__',
            '.pytest_cache',
            '.mypy_cache',
            '.ipynb_checkpoints',
        }
    },
    view = {
        width = 30,
        height = 30,
        hide_root_folder = false,
        side = 'left',
        auto_resize = false,
        mappings = {
            custom_only = false,
            list = {}
        }
    },
    mappings = {
        list = {
            { key = 'v', cb = tree_cb('vsplit') },
            { key = 's', cb = tree_cb('split') },
        }
    }
}