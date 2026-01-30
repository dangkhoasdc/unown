require "nvchad.mappings"

local map = vim.keymap.set

-- General

-- TODO
map("n", "<leader>td", "<cmd>TodoQuickFix<cr>", { desc = "Todo" })

-- Telescope
-- Note: builtin is loaded lazily via function wrappers to improve startup time
map("n", "<leader>fW", function()
  require("telescope.builtin").grep_string()
end, { desc = "[F]ind current [W]ord" })

map("n", "<leader>fw", function()
  require("telescope").extensions.live_grep_args.live_grep_args()
end, { desc = "[F]ind [w]ord with args" })

-- frecency mapping moved to plugin spec for lazy loading

map("n", "<leader>fs", function()
  require("telescope.builtin").lsp_document_symbols {
    symbol_width = 50,
    symbols = {
      "Class",
      "Function",
      "Method",
      "Variable",
      "Property",
      "Field",
      "Constructor",
      "Interface",
      "Module",
      "Struct",
      "Enum",
      "Constant",
    },
  }
end, { desc = "[F]ind [S]ymbols", noremap = true, silent = true })

-- remap terms, otherwise it conflicts which resizing panes/windows

vim.keymap.del("n", "<A-h>")
vim.keymap.del("n", "<A-v>")
vim.keymap.del("n", "<leader>cm")

-- toggleable
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-b>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

-- smart-splits keymaps moved to plugin spec for lazy loading

-- replace the current word
-- author: https://stackoverflow.com/a/5543793
map({ "n", "i" }, "<F4>", ":%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i", { desc = "Replace current word" })

map({ "n", "x" }, "gra", function()
  require("tiny-code-action").code_action()
end, { noremap = true, silent = true, desc = "Open Code Action" })

-- TAB
map("n", "<TAB>", "<C-^>", { noremap = true, silent = true, desc = "Toggle last buffer" })
map("n", "<S-TAB>", function()
  require("telescope.builtin").buffers {
    show_all_buffers = true,
    sort_lastused = true,
    ignore_current_buffer = true,
  }
end, { noremap = true, silent = true, desc = "Telescope Buffers" })

map('n', ']c', function()
  if vim.wo.diff then
    vim.cmd.normal({ ']c', bang = true })
  else
    require('gitsigns').nav_hunk('next')
  end
end, { noremap = true, silent = true, desc = "Next Git Hunk" })

map('n', '[c', function()
  if vim.wo.diff then
    vim.cmd.normal({ '[c', bang = true })
  else
    require('gitsigns').nav_hunk('prev')
  end
end, { noremap = true, silent = true, desc = "Prev Git Hunk" })

map('n', '\\q', function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  local action = qf_winid > 0 and 'cclose' or 'copen'
  vim.cmd('botright ' .. action)
end, { noremap = true, silent = true })

-- Others
map('n', "<F12>", ":Lazy sync<cr>", {desc = "Sync Plugins"})
