vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- Highlight overrides: apply after any colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "Constant", { fg = "#edc168" })
    vim.api.nvim_set_hl(0, "@constant", { fg = "#edc168" })
    vim.api.nvim_set_hl(0, "@constant.builtin", { fg = "#edc168" })
    vim.api.nvim_set_hl(0, "@constant.macro", { fg = "#edc168" })
  end,
})

-- Load nightfox colorscheme (overrides base46 with full theme + colorblind support)
vim.cmd.colorscheme "carbonfox"

-- Re-apply NvChad statusline (nightfox covers most other integrations natively)
pcall(dofile, vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)
