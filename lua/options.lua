require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Folding settings
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- session config
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- line number
vim.o.number = false

-- cmp setting
local cmp = require "cmp"
local config = cmp.get_config()
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match "^%s*$" == nil
end

table.insert(config.sources, {
  name = "copilot",
})
config.mapping = cmp.mapping.preset.insert ({
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() and has_words_before() then
      cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
    else
      fallback()
    end
  end, { "i", "s" }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
     cmp.select_prev_item()
    else
      fallback()
    end
   end, { "i", "s" }),
})

cmp.setup(config)
