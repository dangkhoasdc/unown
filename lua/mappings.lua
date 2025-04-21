require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local builtin = require 'telescope.builtin'
local smart_splits = require 'smart-splits'

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


vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)

vim.keymap.set("n", "<leader><leader>", function()
  require("telescope").extensions.smart_open.smart_open()
end, { noremap = true, silent = true })

vim.keymap.set("n", "gl", "<Plug>(VesselViewLocalJumps)")
vim.keymap.set("n", "gL", "<Plug>(VesselViewExternalJumps)")

-- replace the current word
-- author: https://stackoverflow.com/a/5543793
vim.keymap.set({"n", "i"}, "<F4>", ":%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i")

