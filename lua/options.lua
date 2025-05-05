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
local cmp = require('cmp')
local config = cmp.get_config()
table.insert(config.sources, {
  name = 'copilot',
})
cmp.setup(config)
