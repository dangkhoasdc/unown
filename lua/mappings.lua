require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Undo Tree"})
map("n", "<leader>td", "<cmd>TodoQuickFix<cr>", { desc = "Todo"})

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
