return {
  -- General
  -- Deal with editing config file
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      enabled = function()
        return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
      end,
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
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
      require("lint").linters_by_ft = {
        make = { "checkmake" },
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
        "python",
        "go",
        "diff",
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
    build = "make install_jsregexp",
  },

  {
    "folke/trouble.nvim",
    opts = {
      preview = {
        type = "float",
      },
    }, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    lazy = false,
    keys = {
      {
        "<leader>tt",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>tl",
        "<cmd>Trouble lsp toggle focus=true  win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
    },
  },

  -- yanking
  {
    "gbprod/yanky.nvim",
    lazy = false,
    dependencies = {
      { "kkharji/sqlite.lua" },
    },
    opts = {
      ring = { storage = "sqlite" },
    },
  },

  -- Movements
  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function()
      -- Fix: https://github.com/ggandor/leap.nvim/issues/224
      vim.keymap.set('n',        'ss', '<Plug>(leap-anywhere)')
      vim.keymap.set({'x', 'o'}, 'ss', '<Plug>(leap)')
    end,
  },

  -- Undo
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle"
  },

  -- Comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "TodoQuickFix",
    opts = {},
  },

  -- folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    lazy = false,
    config = function()
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      require("ufo").setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      }
    end,
  },

  -- better search
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>sS", mode = { "n" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- code outline
  {
    "stevearc/aerial.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>a", "<cmd>AerialToggle!<CR>", desc = "Aerial Toggle" },
    },
  },

  -- annotations
  {
    "danymat/neogen",
    config = true,
    keys = {
      {
        "<leader>ga",
        ":lua require('neogen').generate()<CR>",
        desc = "[G]enerate [A]nnotations",
        noremap = true,
        silent = true,
      },
    },
  },

  -- UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },

  -- save and restore sessions
  {
    "rmagatti/auto-session",
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {},
  },

  -- window management
  {
    "mrjones2014/smart-splits.nvim",
    opts = {
      default_amount = 10,
    },
  },

  -- mini
  { "echasnovski/mini.ai", version = false, lazy = false },
  {
    "echasnovski/mini.surround",
    version = false,
    lazy = false,
    config = function()
      require("mini.surround").setup()
    end,
  },

  -- navigations
  {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    config = function()
      require("telescope").load_extension "smart_open"
    end,
    dependencies = {
      "kkharji/sqlite.lua",
      -- Only required if using match_algorithm fzf
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
      { "nvim-telescope/telescope-fzy-native.nvim" },
    },
  },

  {
    "gcmt/vessel.nvim",
    opts = {
      create_commands = true,
    },
    keys = {
      {
        "gj",
        "<Plug>(VesselViewLocalJumps)",
        "[Go] local [j]umps View",
      },
      {
        "gJ",
        "<Plug>(VesselViewExternalJumps)",
        "[Jump] global [J]umps View",
      },
      {
        "gm",
        "<Plug>(VesselViewMarks)",
        "[Go] [m]arks",
      },
    },
  },
  -- # PROGRAMMING LANGUAGES
  -- JSON
  {
    "gennaro-tedesco/nvim-jqx",
    event = { "BufReadPost" },
    ft = { "json", "yaml" },
  },
  -- Golang
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    -- branch = "develop"
    -- (optional) will update plugin's deps on every update
    build = function()
      vim.cmd.GoInstallDeps()
    end,
    ---@type gopher.Config
    opts = {},
  },
  -- Python
  {
    "kiyoon/python-import.nvim",
    -- build = "pipx install . --force",
    build = "uv tool install . --force --reinstall",
    lazy = false,
    ft = "python",
    keys = {
      {
        "<leader>i",
        function()
          require("python_import.api").add_import_current_word_and_notify()
        end,
        mode = { "n" },
        silent = true,
        desc = "Add python import",
        ft = "python",
      },
    },
    opts = {
      extend_lookup_table = {
        ---@type table<string, string[]>
        statement_after_imports = {
          logger = vim.NIL,
        },

        ---@type table<string, string>
        import_from = {
          logger = "loguru",
        },
      },
    },
  },
}
