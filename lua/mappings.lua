require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local builtin = require 'telescope.builtin'

-- Telescope
vim.keymap.set('n', '<leader>fW', builtin.grep_string, { desc = '[F]ind current [W]ord' })

map("i", "jk", "<ESC>")
map("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Undo Tree" })
map("n", "<leader>td", "<cmd>TodoQuickFix<cr>", { desc = "Todo" })

-- remapp terms, otherwise it conflicts which resizing panes/windows

vim.keymap.del("n", "<A-h>")
vim.keymap.del("n", "<A-v>")

-- toggleable
map({ "n", "t" }, "<leader>v", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<leader>h", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })
