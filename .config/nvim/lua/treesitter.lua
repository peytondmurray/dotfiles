require('nvim-treesitter.configs').setup {
    autotag = {
        enable = true,
        filetypes = {
            'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript',
            'xml',
            'php',
            'markdown',
            'astro', 'glimmer', 'handlebars', 'hbs',
            'njk'
        }
    },
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
    },
    indent = {
        enable = true,
        disable = { "python" }
    },
    autopairs = {
        enable = true
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["<M-j>"] = "@function.outer",
                ["<M-J>"] = "@class.outer",
            },
            goto_next_end = {
                ["<M-C-j>"] = "@function.outer",
                ["<M-C-J>"] = "@class.outer",
            },
            goto_previous_start = {
                ["<M-k>"] = "@function.outer",
                ["<M-K>"] = "@class.outer",
            },
            goto_previous_end = {
                ["<M-C-k>"] = "@function.outer",
                ["<M-C-K>"] = "@class.outer",
            },
        },
    },
}
