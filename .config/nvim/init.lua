local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
      "m00qek/baleia.nvim",
      version = "*",
      config = function()
        vim.g.baleia = require("baleia").setup({ })

        -- Command to colorize the current buffer
        vim.api.nvim_create_user_command("BaleiaColorize", function()
          vim.g.baleia.once(vim.api.nvim_get_current_buf())
        end, { bang = true })

        -- Command to show logs
        vim.api.nvim_create_user_command("BaleiaLogs", vim.g.baleia.logger.show, { bang = true })
      end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {'nvim-web-devicons'},
    },
    'kyazdani42/nvim-web-devicons',
    'junegunn/vim-easy-align',

    {
        'luukvbaal/stabilize.nvim',
        config = function() require('stabilize').setup() end
    },

    'glench/vim-jinja2-syntax',
    'jxnblk/vim-mdx-js',

    {
        'danymat/neogen',
        config = function()
            require('neogen').setup {
                enabled = true,
                languages = {
                    python = {
                        template = {
                            annotation_convention = 'numpydoc'
                        }
                    }
                }
            }
        end
    },

    "hat0uma/csvview.nvim",
    {
        "esmuellert/vscode-diff.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        cmd = "CodeDiff",
    },
    {
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup()
        end
    },

    -- DAP
    'mfussenegger/nvim-dap',
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio',
        }
    },
    {
        'leoluz/nvim-dap-go',
        config = function()
            require('dap-go').setup({
                dap_configurations = {
                    {
                        type = "go",
                        name = "Attach remote",
                        mode = "remote",
                        request = "attach",
                        -- program = "${workspaceFolder}/main.go",
                    },
                  }
            })
        end
    },

    -- File browser
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = {'kyazdani42/nvim-web-devicons'},
        config = function()
            require("nvim-tree").setup({
                filters = {
                    custom = { "^\\.git$" }
                }
            })
        end
    },

    -- Toggle, display, and navigate marks
     'kshenoy/vim-signature',
    'windwp/nvim-ts-autotag',

    -- Check mapping conflicts with :CheckMappingConflicts
    {'lukhio/vim-mapping-conflicts', cmd = 'CheckMappingConflicts'},

    -- Show a popup menu of keybindings when you press a button and wait for a bit
    {
        'folke/which-key.nvim',
        event = "VeryLazy",
    },

    -- Symbols browser
    {
        "hedyhli/outline.nvim",
        config = function()
            require("outline").setup({
                symbols = {
		            filter = {
                        python = { 'Function', 'Class' },
	                }
                }
            })
        end,
    },

    -- Indent guides
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('ibl').setup({
                indent = {
                    char = '│'
                },
                scope = {
                    enabled = true,
                }
            })
        end
    },

    -- Neovim in the browser
    {
        'glacambre/firenvim',
        build = ":call firenvim#install(0)",
    },

    -- Colorschemes
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                styles = {
                    italic = false
                },
                highlight_groups = {
                    Cursor = {
                        fg = "gold"
                    }
                }
            })
        end
    },

    -- Themes
    -- 'savq/melange',
    --  'Mofiqul/dracula.nvim'
    --  'EdenEast/nightfox.nvim'
    --  'folke/tokyonight.nvim'
    --  {
    --     'ellisonleao/gruvbox.nvim',
    --     config = function()
    --         require('gruvbox').setup({
    --             italic = false
    --         })
    --     end
    -- }

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },

    'rktjmp/lush.nvim',
    {
        'echasnovski/mini.nvim',
        version = false,
        config = function()
            require('mini.ai').setup()
            require('mini.align').setup()
            require('mini.comment').setup({
                mappings = {
                    comment = ' c',
                    comment_line = ' c',
                    comment_visual = ' c',
                    textobject = '',
                }
            })
            require('mini.cursorword').setup()
            require('mini.hipatterns').setup({
                highlighters = {
                    hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
                }
            })
            require('mini.notify').setup()
        end
    },
    -- Git Integration
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup{
                current_line_blame = true,
            }
        end
    },
    {
        'sindrets/diffview.nvim',
        config = function() require('diffview').setup() end,
        cmd = {
            'DiffviewOpen'
        }
    },
    'tpope/vim-fugitive',

    -- Telescope
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },
    'nvim-lua/plenary.nvim',
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-telescope/telescope-live-grep-args.nvim'
        },
    },

    -- Completion
    -- https://github.com/SmiteshP/nvim-navic
    'neovim/nvim-lspconfig',
    {
        'saghen/blink.cmp',
        dependencies = {
            'rafamadriz/friendly-snippets',
            {
                'allaman/emoji.nvim',
                -- config = function() require("emoji").setup({enable_cmp_integration = true}) end
            },
            'saghen/blink.compat',
        },
        version = '1.*',
        opts = {
            keymap = {
                preset = 'enter',

                ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
                ['<C-j>'] = { 'select_next', 'fallback_to_mappings' },

                -- This makes Esc act like it works in insert mode normally, except it _also_
                -- closes the completion menu.
                -- Any blink.cmp keymap that returns false or nil will cause blink.cmp to call the
                -- next keymap. 'fallback' is needed to return Esc to the default keybinding used
                -- outside of the completion menu.
                ['<Esc>'] = {
                    function(cmp)
                        cmp.cancel()
                        return nil
                    end,
                    'fallback'
                },
                ['<CR>'] = { 'accept', 'fallback_to_mappings' },
            },
            completion = {
                documentation = {
                    auto_show = true
                },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = true,
                    }
                }
            },
            sources = {
                default = {'emoji', 'lazydev', 'lsp', 'path', 'snippets', 'buffer'},
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                    emoji = {
                        name = "emoji",
                        module = "blink.compat.source",
                        -- overwrite kind of suggestion
                        transform_items = function(ctx, items)
                            local kind = require("blink.cmp.types").CompletionItemKind.Text
                            for i = 1, #items do
                                items[i].kind = kind
                            end
                            return items
                        end,
                    }
                },
            },
        }
    },
    'folke/lazydev.nvim',
    {
        'ray-x/lsp_signature.nvim',
        config = function() require('lsp_signature').setup() end,
    },
    {
        'j-hui/fidget.nvim',
        tags = '*'
    },

    -- A suite of rust tools
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Recommended
        lazy = false,   -- This plugin is already lazy
    },

    'p00f/clangd_extensions.nvim',

    -- Tree-sitter
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter',
                build = ':TSUpdate',
                event = { 'BufRead', 'BufNewFile', 'InsertEnter' }
            },

        },
    },
    'nvim-treesitter/nvim-treesitter-context',
    {
        "chrisgrieser/nvim-various-textobjs",
        config = function ()
            require("various-textobjs").setup({ keymaps = { useDefaults = true }})
        end,
    },

    -- Line diffs
    'AndrewRadev/linediff.vim',

    'jbyuki/venn.nvim',
    {
        'terrastruct/d2-vim',
        ft = { 'd2' }
    },

    -- Discord presence
    'andweeb/presence.nvim',

    -- AI
    {
        "olimorris/codecompanion.nvim",
        version = "^v18.0.0",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("codecompanion").setup({
                adapters = {
                    acp = {
                        opts = {
                            show_presets = false,
                        },
                        gemini_cli = function()
                            return require("codecompanion.adapters").extend("gemini_cli", {
                                defaults = {
                                    auth_method = "oauth-personal",
                                },
                            })
                        end,
                        codex = function()
                            return require("codecompanion.adapters").extend("codex", {
                                defaults = {
                                    auth_method = "chatgpt",
                                },
                            })
                        end,
                    },
                    http = {
                        opts = {
                            show_presets = false,
                        },
                    },
                },

                -- HTTP adapters only for inline/cmd/background to explicitly disable copilot
                interactions = {
                    chat = {
                        adapter = "gemini_cli",
                        model = "gemini-3-pro-preview",
                    },
                    inline = {
                        adapter = "gemini_cli",
                        model = "gemini-3-pro-preview",
                    },
                    cmd = {
                        adapter = "gemini_cli",
                        model = "gemini-3-pro-preview",
                    },
                    background = {
                        adapter = "gemini_cli",
                        model = "gemini-3-pro-preview",
                    },
                },
            })
        end,
    },
    "juacker/git-link.nvim",

    {
        "doculus.nvim",
        dir = "~/dev/doculus.nvim/",
        config = function()
            require("doculus").setup()
        end,
    },
})


require('options')
require('statusline')
require('keybindings')
require('treesitter')
require('dapconfig')
require('telescope').setup{
    colorscheme = {
        enable_preview = true,
    },
    pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
    winblend = 20,
    defaults = {
        file_ignore_patterns = {
            'node_modules/',
            'yarn.lock',
            'compile_commands.json'
        },
    },
    extensions = {
        live_grep_args = {
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--hidden",
                "--glob=!.git/",
            }
        }
    }
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')
require('telescope').load_extension('emoji')
require('styles')
require('tree')
require('lsp')
