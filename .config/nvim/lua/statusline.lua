local config = {
    options = {
        -- theme = "tokyonight",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        -- section_separators = { "", "" },
        -- component_separators = { "", "" },
        icons_enabled = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { { "diagnostics", sources = { "nvim_diagnostic" } }, "filename" },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    extensions = { "nvim-tree" },
}

-- try to load matching lualine theme
-- local name = vim.g.colors_name or ""
-- local ok, _ = pcall(require, "lualine.themes." .. name)
-- if ok then
--     config.options.theme = name
-- end
require("lualine").setup(config)
