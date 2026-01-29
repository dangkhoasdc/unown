require "nvchad.autocmds"

local macro_group = vim.api.nvim_create_augroup("MacroRecording", { clear = true })
vim.api.nvim_create_autocmd("RecordingLeave", {
  group = macro_group,
  callback = function()
    print "Stopped Macro Recording"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "clojure",
  callback = function()
    vim.opt_local.foldmethod = "manual"
    vim.opt_local.foldenable = false -- Start with all folds open
  end,
})
