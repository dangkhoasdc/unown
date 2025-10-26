require "nvchad.autocmds"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "clojure",
  callback = function()
    vim.opt_local.foldmethod = "manual"
    vim.opt_local.foldenable = false -- Start with all folds open
  end,
})
