require "nvchad.mappings"

local map = vim.keymap.set

-- General
-- Undotree
map("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Undo Tree" })

-- TODO
map("n", "<leader>td", "<cmd>TodoQuickFix<cr>", { desc = "Todo" })

-- Telescope
local builtin = require "telescope.builtin"
map("n", "<leader>fW", builtin.grep_string, { desc = "[F]ind current [W]ord" })

-- remapp terms, otherwise it conflicts which resizing panes/windows

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

map("n", "<leader><leader>", function()
  require("telescope").extensions.smart_open.smart_open()
end, { desc = "Smart Open", noremap = true, silent = true })

-- replace the current word
-- author: https://stackoverflow.com/a/5543793
map({ "n", "i" }, "<F4>", ":%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i", { desc = "Replace current word" })

-- yanky
map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
map({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
map({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

map("n", "<A-p>", "<Plug>(YankyPreviousEntry)", { desc = "Prev Yanky Entry" })
map("n", "<A-n>", "<Plug>(YankyNextEntry)", { desc = "Next Yanky Entry" })

map("n", "<leader>pp", function()
  require("telescope").extensions.yank_history.yank_history()
end, { noremap = true, silent = true, desc = "Telescope Yank History" })

map({ "n", "x" }, "gra", function()
  require("tiny-code-action").code_action()
end, { noremap = true, silent = true, desc = "Open Code Action" })

-- CodeCompanions
map(
  { "n", "v" },
  "<localleader>ca",
  "<cmd>CodeCompanionActions<cr>",
  { desc = "Code[c]ompanion [a]ctions", noremap = true, silent = true }
)
map(
  { "n", "v" },
  "<localleader>cc",
  "<cmd>CodeCompanionChat Toggle<cr>",
  { desc = "Code[c]companion [c]hat", noremap = true, silent = true }
)
map(
  "v",
  "<localleader>cA",
  "<cmd>CodeCompanionChat Add<cr>",
  { desc = "Code[c]ompanion [c]hat add", noremap = true, silent = true }
)
