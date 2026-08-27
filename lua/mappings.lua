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

map("n", "<leader>fg", function()
  require("telescope.builtin").git_status()
end, { desc = "[F]ind [G]it changes" })

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
map("t", "<Tab>", "<Tab>", { desc = "Pass Tab to terminal" })
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

-- Avante with AWS SSO auto-login check
local function avante_with_aws_check(cmd)
  vim.fn.jobstart({ "aws", "sts", "get-caller-identity", "--profile", "claude-code" }, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        vim.schedule(function() vim.cmd(cmd) end)
        return
      end
      vim.schedule(function()
        vim.ui.input({ prompt = "AWS SSO session expired. Login? [y/N]: " }, function(input)
          if not (input and input:lower():match "^y") then
            vim.notify("AWS login skipped — avante may not work", vim.log.levels.WARN)
            return
          end
          -- :new (not :split) so termopen gets a fresh buffer; :split would
          -- convert the current buffer into the terminal in both windows
          vim.cmd "botright 15new"
          local term_buf = vim.api.nvim_get_current_buf()
          vim.fn.termopen("aws sso login --profile claude-code", {
            on_exit = function(_, code)
              vim.schedule(function()
                -- close the login terminal split and wipe its buffer
                for _, win in ipairs(vim.fn.win_findbuf(term_buf)) do
                  pcall(vim.api.nvim_win_close, win, true)
                end
                pcall(vim.api.nvim_buf_delete, term_buf, { force = true })
                if code == 0 then
                  vim.notify("AWS SSO login succeeded", vim.log.levels.INFO)
                  vim.cmd(cmd) -- auto-run the original Avante command
                else
                  vim.notify("AWS SSO login failed (exit " .. code .. ")", vim.log.levels.ERROR)
                end
              end)
            end,
          })
          vim.cmd "startinsert"
        end)
      end)
    end,
  })
end

map("n", "<localleader>ca", function() avante_with_aws_check "AvanteAsk" end, { desc = "Avante [A]sk" })
map("n", "<localleader>cc", function() avante_with_aws_check "AvanteToggle" end, { desc = "Avante Chat Toggle" })
map("n", "grc", function() avante_with_aws_check "AvanteAsk" end, { desc = "Avante Ask" })

-- Others
map('n', "<F12>", ":Lazy sync<cr>", { desc = "Sync Plugins" })
