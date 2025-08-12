require "nvchad.options"

-- session config
vim.o.sessionoptions = "blank,buffers,curdir,folds,tabpages,winsize,winpos,terminal,localoptions"

-- line number
vim.o.number = false

local macro_group = vim.api.nvim_create_augroup("MacroRecording", { clear = true })
vim.api.nvim_create_autocmd("RecordingLeave", {
  group = macro_group,
  callback = function()
    print "Stopped Macro Recording"
  end,
})

-- plugin config
require "configs.cmp"
