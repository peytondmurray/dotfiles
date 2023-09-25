require('nvim-tree').setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = false,
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
        adaptive_size = true,
        width = 30,
        side = 'left',
    },
    sort_by = "extension",
}
