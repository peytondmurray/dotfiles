-- Strip trailing whitespace on save; remove blank line at end of file
StripWhitespace = function()
    vim.cmd('%s/\\s\\+$//e')
    vim.cmd('%s/\\($\\n\\s*\\)\\+\\%$//e')
end

local ReplaceTC = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Check whether the prior character is whitespace
local is_prior_char_whitespace = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (shift-)tab to:
--- move to prev/next item in completion/snippet menu
--- insert a simple tab
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return ReplaceTC('<C-n>')
    elseif require('luasnip').expand_or_jumpable() then
        return ReplaceTC('<cmd>lua require("luasnip").jump(1)<CR>')
    elseif is_prior_char_whitespace() then
        return ReplaceTC('<Tab>')
    else
        return vim.fn['compe#complete']()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return ReplaceTC('<C-p>')
    elseif require('luasnip').jumpable(-1) then
        return ReplaceTC('<cmd>lua require("luasnip").jump(-1)<CR>')
    else
        return ReplaceTC('<S-Tab>')
    end
end

-- Use <CR> to:
-- expand a snippet
-- insert a simple tab
_G.expand_cr = function()
    if require('luasnip').expand_or_jumpable() then
        return ReplaceTC('<Plug>luasnip-expand-or-jump')
    end
    return ReplaceTC('<CR>')
end