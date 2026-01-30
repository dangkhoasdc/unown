require "nvchad.options"

-- session config
vim.o.sessionoptions = "blank,buffers,curdir,folds,tabpages,winsize,winpos,terminal,localoptions"

-- line number
vim.o.number = false

vim.o.wrap = false

-- window setting
vim.o.splitkeep = "cursor"
vim.o.winwidth = 20
vim.o.winminwidth = 15
vim.o.winheight = 15
vim.o.winminheight = 10
vim.o.equalalways = false

-- center the cursor
vim.o.scrolloff = 999

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
    ["vifmrc"] = "vim",
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

-- Current indent line highlight
vim.cmd.highlight "IndentLineCurrent guifg=#29ab87"

-- Defer cmp config loading until InsertEnter for faster startup
vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    require "configs.cmp"
  end,
})
