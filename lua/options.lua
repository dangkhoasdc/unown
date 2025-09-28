require "nvchad.options"

-- session config
vim.o.sessionoptions = "blank,buffers,curdir,folds,tabpages,winsize,winpos,terminal,localoptions"

-- line number
vim.o.number = false

vim.o.wrap = false

-- window setting
vim.o.splitkeep = 'cursor'
vim.o.winwidth = 20
vim.o.winminwidth = 15
vim.o.winheight = 20
vim.o.winminheight = 10
vim.o.equalalways = false

-- center the cursor
vim.o.scrolloff = 999

local macro_group = vim.api.nvim_create_augroup("MacroRecording", { clear = true })
vim.api.nvim_create_autocmd("RecordingLeave", {
  group = macro_group,
  callback = function()
    print "Stopped Macro Recording"
  end,
})

-- Module for defining new filetypes. I picked up these configurations based on inspirations from this dotfiles repo:
-- https://github.com/davidosomething/dotfiles/blob/be22db1fc97d49516f52cef5c2306528e0bf6028/nvim/lua/dko/filetypes.lua

vim.filetype.add {
  -- Detect and assign filetype based on the extension of the filename
  extension = {
    mdx = "mdx",
    log = "log",
    conf = "conf",
    env = "dotenv",
  },
  -- Detect and apply filetypes based on the entire filename
  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
    ["tsconfig.json"] = "jsonc",
  },
  -- Detect and apply filetypes based on certain patterns of the filenames
  pattern = {
    -- INFO: Match filenames like - ".env.example", ".env.local" and so on
    ["%.env%.[%w_.-]+"] = "dotenv",
    ["openapi.*%.ya?ml"] = "yaml.openapi",
    ["openapi.*%.json"] = "json.openapi",
    ["api.*%.ya?ml"] = "yaml.openapi",
    ["api.*%.json"] = "json.openapi",
  },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = ".env*",
  command = "set filetype=dotenv | set syntax=bash",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = "vifmrc",
  command = "set filetype=vim | set syntax=vim",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = "*api*.y?ml",
  command = "set filetype=yaml.openapi | set syntax=yaml",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = "*api*.json",
  command = "set filetype=json.openapi | set syntax=json",
})
-- plugin config
require "configs.cmp"
