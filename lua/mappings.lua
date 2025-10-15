require "nvchad.mappings"

local map = vim.keymap.set

-- General

-- TODO
map("n", "<leader>td", "<cmd>TodoQuickFix<cr>", { desc = "Todo" })

-- Telescope
local builtin = require "telescope.builtin"
map("n", "<leader>fW", builtin.grep_string, { desc = "[F]ind current [W]ord" })

map("n", "<leader><leader>",
  ':Telescope frecency workspace=CWD path_display={"filename_first"} theme=ivy<cr>',
  { desc = "File Open", noremap = true, silent = true })

map("n", "<leader>fs", function()
  builtin.lsp_document_symbols {
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
map({ "n", "t" }, "<leader>v", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<leader>h", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
map("n", "<A-h>", require("smart-splits").resize_left)
map("n", "<A-j>", require("smart-splits").resize_down)
map("n", "<A-k>", require("smart-splits").resize_up)
map("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
map("n", "<C-h>", require("smart-splits").move_cursor_left)
map("n", "<C-j>", require("smart-splits").move_cursor_down)
map("n", "<C-k>", require("smart-splits").move_cursor_up)
map("n", "<C-l>", require("smart-splits").move_cursor_right)
map("n", "<C-\\>", require("smart-splits").move_cursor_previous)

-- replace the current word
-- author: https://stackoverflow.com/a/5543793
map({ "n", "i" }, "<F4>", ":%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i", { desc = "Replace current word" })

map({ "n", "x" }, "gra", function()
  require("tiny-code-action").code_action()
end, { noremap = true, silent = true, desc = "Open Code Action" })

-- TAB
map("n", "<TAB>", "<C-^>", { noremap = true, silent = true, desc = "Toggle last buffer" })
map("n", "<S-TAB>", function()
  builtin.buffers {
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

vim.keymap.set('n', '\\q', function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  local action = qf_winid > 0 and 'cclose' or 'copen'
  vim.cmd('botright ' .. action)
end, { noremap = true, silent = true })
