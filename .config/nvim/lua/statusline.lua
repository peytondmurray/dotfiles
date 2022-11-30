local palette = require('melange.palettes.dark')
-- local nf_palette = require('nightfox.palette').load()
-- local palette = require('gruvbox.palette')
local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')
local gps = require("nvim-gps")

local force_inactive = {
    filetypes = {},
    buftypes = {},
    bufnames = {}
}


local colors = {
    bg             = palette.a.bg,
    fg             = palette.a.fg,
    dark_black     = palette.a.bg,
    dark_red       = palette.d.red,
    dark_green     = palette.d.green,
    dark_yellow    = palette.d.yellow,
    dark_blue      = palette.d.blue,
    dark_magenta   = palette.d.magenta,
    dark_cyan      = palette.d.cyan,
    dark_white     = palette.a.com,
    black          = palette.a.overbg,
    red            = palette.c.red,
    green          = palette.c.green,
    yellow         = palette.c.yellow,
    blue           = palette.c.blue,
    magenta        = palette.c.magenta,
    cyan           = palette.c.cyan,
    white          = palette.a.faded,
    bright_black   = palette.a.sel,
    bright_red     = palette.b.red,
    bright_green   = palette.b.green,
    bright_yellow  = palette.b.yellow,
    bright_blue    = palette.b.blue,
    bright_magenta = palette.b.magenta,
    bright_cyan    = palette.b.cyan,
    bright_white   = palette.a.fg,
    skyblue        = palette.c.cyan,
    violet         = palette.d.magenta,
}

-- nightfox
-- local colors = {
--     bg = nf_palette.bg1,
--     black = nf_palette.black,
--     yellow = nf_palette.yellow,
--     cyan = nf_palette.cyan,
--     green = nf_palette.green,
--     orange = nf_palette.orange,
--     violet = nf_palette.pink,
--     magenta = nf_palette.magenta,
--     white = nf_palette.white,
--     fg = nf_palette.fg1,
--     skyblue = nf_palette.blue,
--     red = nf_palette.red,
-- }

-- gruvbox
-- local colors = {
--     bg = palette.dark0,
--     black = palette.dark0_hard,
--     yellow = palette.bright_yellow,
--     cyan = palette.bright_blue,
--     green = palette.bright_green,
--     orange = palette.bright_orange,
--     violet = palette.bright_purple,
--     magenta = palette.faded_purple,
--     white = palette.light0,
--     fg = palette.light4,
--     skyblue = palette.bright_aqua,
--     red = palette.bright_red,
-- }

local vi_mode_colors = {
    NORMAL = 'green',
    OP = 'green',
    INSERT = 'red',
    CONFIRM = 'red',
    VISUAL = 'skyblue',
    LINES = 'skyblue',
    BLOCK = 'skyblue',
    REPLACE = 'violet',
    ['V-REPLACE'] = 'violet',
    ENTER = 'cyan',
    MORE = 'cyan',
    SELECT = 'orange',
    COMMAND = 'green',
    SHELL = 'green',
    TERM = 'green',
    NONE = 'yellow'
}

local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
        return true
    end
    return false
end

local checkwidth = function()
    local squeeze_width    = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

force_inactive.filetypes = {
    'NvimTree',
    'dbui',
    'packer',
    'startify',
    'fugitive',
    'fugitiveblame'
}

force_inactive.buftypes = {
    'terminal'
}

-- LEFT
local left = {
    {
        -- mode
        provider = function()
            return ' '..vi_mode_utils.get_vim_mode()..' '
        end,
        hl = function()
            return {
                name = vi_mode_utils.get_mode_highlight_name(),
                bg = vi_mode_utils.get_mode_color(),
                fg = 'black',
                style = 'bold',
            }
        end,
        right_sep = ' '
    },
    -- filename
    {
        provider = function()
            return vim.fn.expand("%:F")
        end,
        hl = {
            fg = 'white',
            bg = 'bg',
            style = 'bold'
        },
        right_sep = {
            str = ' ',
            hl = {
                fg = 'white',
                bg = 'bg',
                style = 'bold'
            },
        }
    },
    -- nvimGps
    {
        provider = function() return gps.get_location() end,
        enabled = function() return gps.is_available() end,
        hl = {
            fg = 'white',
            bg = 'bg',
            style = 'bold'
        }
    },
}

local mid = {
    -- gitBranch
    {
        provider = 'git_branch',
        hl = {
            fg = 'yellow',
            bg = 'bg',
            style = 'bold'
        }
    },
    -- diffAdd
    {
        provider = 'git_diff_added',
        hl = {
            fg = 'green',
            bg = 'bg',
            style = 'bold'
        }
    },
    -- diffModified
    {
        provider = 'git_diff_changed',
        hl = {
            fg = 'orange',
            bg = 'bg',
            style = 'bold'
        }
    },
    -- diffRemove
    {
        provider = 'git_diff_removed',
        hl = {
            fg = 'red',
            bg = 'bg',
            style = 'bold'
        },
    },
    -- diagnosticErrors
    {
        provider = 'diagnostic_errors',
        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR) end,
        hl = {
            fg = 'red',
            style = 'bold'
        }
    },
    -- diagnosticWarn
    {
        provider = 'diagnostic_warnings',
        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.WARN) end,
        hl = {
            fg = 'yellow',
            style = 'bold'
        }
    },
    -- diagnosticHint
    {
        provider = 'diagnostic_hints',
        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.HINT) end,
        hl = {
            fg = 'cyan',
            style = 'bold'
        }
    },
    -- diagnosticInfo
    {
        provider = 'diagnostic_info',
        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.INFO) end,
        hl = {
            fg = 'skyblue',
            style = 'bold'
        }
    },
}

local right = {
    -- LspName
    {
        provider = 'lsp_client_names',
        hl = {
            fg = 'yellow',
            bg = 'bg',
            style = 'bold'
        },
        right_sep = ' '
    },
    -- fileIcon
    {
        provider = function()
            local filename = vim.fn.expand('%:t')
            local extension = vim.fn.expand('%:e')
            local icon = require'nvim-web-devicons'.get_icon(filename, extension)
            if icon == nil then
                icon = ''
            end
            return icon
        end,
        hl = function()
            local val = {}
            local filename = vim.fn.expand('%:t')
            local extension = vim.fn.expand('%:e')
            local icon, name = require'nvim-web-devicons'.get_icon(filename, extension)
            if icon ~= nil then
                val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
            else
                val.fg = 'white'
            end
            val.bg = 'bg'
            val.style = 'bold'
            return val
        end,
        right_sep = ' '
    },
    -- fileType
    {
        provider = 'file_type',
        hl = function()
            local val = {}
            local filename = vim.fn.expand('%:t')
            local extension = vim.fn.expand('%:e')
            local icon, name    = require'nvim-web-devicons'.get_icon(filename, extension)
            if icon ~= nil then
                val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
            else
                val.fg = 'white'
            end
            val.bg = 'bg'
            val.style = 'bold'
            return val
        end,
        right_sep = ' '
    },
    -- fileSize
    {
        provider = 'file_size',
        enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
        hl = {
            fg = 'skyblue',
            bg = 'bg',
            style = 'bold'
        },
        right_sep = ' '
    },
    -- fileEncode
    {
        provider = 'file_encoding',
        hl = {
            fg = 'white',
            bg = 'bg',
            style = 'bold'
        },
        right_sep = ' '
    },
    -- lineInfo
    {
        provider = 'position',
        hl = {
            fg = 'white',
            bg = 'bg',
            style = 'bold'
        },
        right_sep = ' '
    },
    -- linePercent
    {
        provider = 'line_percentage',
        hl = {
            fg = 'white',
            bg = 'bg',
            style = 'bold'
        },
        right_sep = ' '
    },
    -- scrollBar
    {
        provider = 'scroll_bar',
        hl = {
            fg = 'yellow',
            bg = 'bg',
        },
    },
}

require('feline').setup({
    theme = colors,
    default_bg = bg,
    default_fg = fg,
    vi_mode_colors = vi_mode_colors,
    components = {
        active = {left, mid, right},
        inactive = {}
    },
    force_inactive = force_inactive,
})
