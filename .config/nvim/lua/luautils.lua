local cmp = require('cmp')

local M = {}

-- Strip trailing whitespace on save; remove blank line at end of file
function M.StripWhitespace()
    vim.cmd('%s/\\s\\+$//e')
    vim.cmd('%s/\\($\\n\\s*\\)\\+\\%$//e')
end

local ReplaceTC = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
function M.TabComplete()
    if vim.fn.pumvisible() == 1 then
        return ReplaceTC('<C-n>')
    elseif require('luasnip').expand_or_jumpable() then
        return ReplaceTC('<cmd>lua require("luasnip").jump(1)<CR>')
    elseif is_prior_char_whitespace() then
        return ReplaceTC('<Tab>')
    else
        return cmp.complete()
    end
end

function M.STabComplete()
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
function M.ExpandCR()
    if require('luasnip').expand_or_jumpable() then
        return ReplaceTC('<Plug>luasnip-expand-or-jump')
    end
    return ReplaceTC('<CR>')
end

return M
