return {

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require "configs.nvtree"
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "mfussenegger/nvim-lint",
    lazy = false,
    config = function()
      require('lint').linters_by_ft = {
        make = { 'checkmake' }
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          local lint_status, lint = pcall(require, "lint")
          if lint_status then
            lint.try_lint()
          end
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "python", "go", "diff"
      },
    },
  },

  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    lazy = false,
  },

  -- Movements
  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function()
      -- Fix: https://github.com/ggandor/leap.nvim/issues/224
      vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)')
      vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
      vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)')
    end,
  },

  -- Undo
  {
    "mbbill/undotree",
    lazy = false,
  },

  -- Comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "TodoQuickFix",
    lazy = false,
    opts = {}
  },

  -- folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    lazy = false,
    config = function()
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end
      })
    end,
  },

}
