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
  group_index = 1,
})
config.mapping = cmp.mapping.preset.insert {
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
}

config.formatting = {
  format = function(entry, vim_item)
    local highlights_info = require("colorful-menu").cmp_highlights(entry)

    -- highlight_info is nil means we are missing the ts parser, it's
    -- better to fallback to use default `vim_item.abbr`. What this plugin
    -- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
    if highlights_info ~= nil then
      vim_item.abbr_hl_group = highlights_info.highlights
      vim_item.abbr = highlights_info.text
    end

    return vim_item
  end,
}

cmp.setup(config)
