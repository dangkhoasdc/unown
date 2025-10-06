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
  -- nvim-tree. Need this for customized UI.
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
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    automatic_enable = {
      exclude = {
        "gopls",
        -- this seems never works.
        "julials",
      }
    },
    opts = {
      ensure_installed = {
        "pylsp",
        "gopls",
        "dockerls",
        "ruff",
        "jsonls",
        "groovyls",
        "yamlls",
        "rust_analyzer",
        "vacuum",
        "bashls",
        "just",
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig"
    },
  },

  -- lsp preview windows
  {
    "rmagatti/goto-preview",
    dependencies = { "rmagatti/logger.nvim" },
    event = "BufEnter",
    config = function()
      require('goto-preview').setup {
        default_mappings = true,
      }
    end,
  },

  -- formatters
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  -- linters
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "configs.nvim-lint"
    end,
  },
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    event = "LspAttach",
    opts = {},
  },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
  },
  {
    "zbirenbaum/neodim",
    event = "LspAttach",
    config = function()
      require("neodim").setup {
        priority = 200,
      }
    end,
  },
  -- show code context on top of the buffer
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup {
        multiline_threshold = 5,
      }
    end,
  },

  -- highlight arguments of functions
  {
    "m-demare/hlargs.nvim",
    lazy = false,
    config = function()
      require("hlargs").setup()
    end,
  },

  -- Organize errors, warnings, references.
  {
    "folke/trouble.nvim",
    opts = {
      preview = {
        type = "float",
        relative = "editor",
        border = "rounded",
        title = "Preview",
        title_pos = "center",
        position = { 0, -2 },
        size = { width = 0.3, height = 0.3 },
        zindex = 200,
      },
    },
    cmd = "Trouble",
    keys = {
      {
        "<leader>tD",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = " [t]rouble [D]iagnostics",
      },
      {
        "<leader>tr",
        "<cmd>Trouble lsp toggle focus=true<cr>",
        desc = "[t]rouble LSP Definitions / [r]eferences / ... ",
      },
      {
        "<leader>tt",
        "<cmd>Trouble telescope toggle<cr>",
        desc = " [t]rouble [t]elescope",
      },
    },
  },

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
    build = "make install_jsregexp",
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
    keys = {
      { "\"",    "<cmd>YankyRingHistory<cr>",  mode = { "n", "x" }, desc = "Open Yank History" },
      { "y",     "<Plug>(YankyYank)",          mode = { "n", "x" }, desc = "Yank text" },
      { "p",     "<Plug>(YankyPutAfter)",      mode = { "n", "x" }, desc = "Put yanked text after cursor" },
      { "P",     "<Plug>(YankyPutBefore)",     mode = { "n", "x" }, desc = "Put yanked text before cursor" },
      { "<A-p>", "<Plug>(YankyPreviousEntry)", mode = { "n" },      desc = "Prev Yanky Entry" },
      { "<A-n>", "<Plug>(YankyNextEntry)",     mode = { "n" },      desc = "Next Yanky Entry" },
    }
  },

  -- AI coding assistant
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          lua = true,
        },
        server_opts_overrides = {
          settings = {
            advanced = {
              listCount = 10,
              inlineSuggestCount = 3,
            },
          },
        },
      }
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    event = { "InsertEnter", "LspAttach" },
    config = function()
      require("copilot_cmp").setup {
        fix_pairs = true,
      }
    end,
    dependencies = {
      "zbirenbaum/copilot.lua",
    },
  },

  {
    "olimorris/codecompanion.nvim",
    keys = {
      { "<localleader>ca", "<cmd>CodeCompanionActions<cr>",     desc = "Code[c]ompanion [a]ctions",  noremap = true, silent = true },
      { "<localleader>cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Code[c]companion [c]hat",    noremap = true, silent = true },
      { "grc",             "<cmd>CodeCompanionChat Add<cr>",    desc = "Code[c]ompanion [c]hat add", noremap = true, silent = true },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      strategies = {
        chat = {
          adapter = "copilot",
        },
      },
      display = {
        chat = {
          window = {
            width = 0.25,
            height = 0.8,
          },
        },
      },
    },
  },

  -- Movements
  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function()
      -- Fix: https://github.com/ggandor/leap.nvim/issues/224
      vim.keymap.set("n", "s", "<Plug>(leap-anywhere)")
      vim.keymap.set({ "x", "o" }, "s", "<Plug>(leap)")

      require('leap').opts.preview_filter =
          function(ch0, ch1, ch2)
            return not (
              ch1:match('%s') or
              ch0:match('%a') and ch1:match('%a') and ch2:match('%a')
            )
          end
    end,
  },
  -- select by on treesitter
  {
    "mfussenegger/nvim-treehopper",
    init = function()
      local keymap = vim.api.nvim_set_keymap
      keymap("n", "g<CR>", '<cmd>lua require("tsht").nodes()<CR>o<ESC>', {
        callback = function()
          require("tsht").nodes()
          -- in visual mode type `o` jumps to the other side of selection.
          -- And then type v to exit visual mode
          vim.cmd "normal! ov"
        end,
        desc = "jump to treesitter node start",
      })
      keymap("n", "g<BS>", "", {
        callback = function()
          require("tsht").nodes()
          vim.cmd "normal! v"
        end,
        desc = "jump to treesitter node end",
      })
      keymap("v", "<CR>", ':<C-U>lua require("tsht").nodes()<CR>', {
        desc = "treesitter nodes",
      })
      keymap("o", "<CR>", "", {
        callback = function()
          require("tsht").nodes()
        end,
        desc = "treesitter nodes",
      })
    end,
  },
  -- a/i operators
  {
    "echasnovski/mini.ai",
    version = false,
    lazy = false,
    config = function()
      require("mini.ai").setup()
    end,
  },

  -- surround
  -- move to kylochui plugin cause I want to have `s` mapping for `flash.nvim` later.
  -- also existsing mapping makes more sense than that of echasnovski
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects' }
    }
  },

  -- -- smart open
  {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    config = function()
      require("telescope").load_extension "smart_open"
      require("telescope").extensions.smart_open.smart_open {
        cwd_only = true,
      }
    end,
    dependencies = {
      "kkharji/sqlite.lua",
      "nvim-telescope/telescope-fzy-native.nvim",
    },
  },

  -- -- jumps & marks management
  {
    "otavioschwanck/arrow.nvim",
    lazy = false,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    opts = {
      show_icons = true,
      leader_key = ";",        -- Recommended to be a single key
      buffer_leader_key = "m", -- Per Buffer Mappings
      index_keys = "1234789zxcbnafghjklwrtyuiop",
    },
  },
  {
    "max397574/better-escape.nvim",
    lazy = false,
    config = function()
      require("better_escape").setup {
        timeout = vim.o.timeoutlen,
        default_mappings = true,
      }
    end,
  },
  -- Undo
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
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
    event = "BufRead",
    config = function()
      -- Folding settings
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      require("ufo").setup {
        close_fold_kinds_for_ft = {
          default = { "imports" },
        },
      }
    end,
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

  -- editing
  {
    "Wansmer/treesj",
    keys = {
      {
        "<leader>j",
        "<cmd>TSJToggle<cr>",
        desc = "Toggle joining block",
        noremap = true,
      },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup {
        use_default_keymaps = false,
      }
    end,
  },

  {
    "cappyzawa/trim.nvim",
    lazy = false,
    config = function()
      require("trim").setup {}
    end,
  },

  -- open other file
  {
    "rgroli/other.nvim",
    config = function()
      require("other-nvim").setup {
        mappings = {
          "golang",
          "python",
        },
      }
    end,
    keys = {
      { "<leader>oo", "<cmd>:Other<CR>",       desc = "[o]pen [o]ther file" },
      { "<leader>ov", "<cmd>:OtherVSplit<CR>", desc = "[o]pen Other [v]split file" },
    },
  },

  -- insert log statements
  {
    "Goose97/timber.nvim",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("timber").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  -- UI
  -- Notification UI
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
          enabled = true,
        },
        signature = {
          enabled = false,
        },
      },
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- disable inc-rename
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
      routes = {
        {
          view = "notify",
          filter = { event = "msg_showmode" },
        },
        {
          view = "cmdline",
          filter = { event = "msg_showmode", any = { { find = "recording" } } },
          opts = { format = { { "󰑊", hl_group = "MacroRecordingIcon" }, " ", "{message}" } },
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },

  -- telescope UI select
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
          },
        },
      }
      require("telescope").load_extension "ui-select"
    end,
  },

  -- trailspace
  {
    "echasnovski/mini.trailspace",
    version = "*",
    lazy = false,
    config = function()
      require("mini.trailspace").setup()
    end,
  },

  -- better Quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = { "qf" },
    opts = {
      auto_resize_height = true,
      preview = {
        winblend = 0,
      },
    },
  },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {
      keys = {
        {
          ">",
          function()
            require("quicker").expand { before = 2, after = 2, add_to_existing = true }
          end,
          desc = "Expand quickfix context",
        },
        {
          "<",
          function()
            require("quicker").collapse()
          end,
          desc = "Collapse quickfix context",
        },
      },
    },
  },

  -- lightbulb
  {
    "kosayoda/nvim-lightbulb",
    config = function()
      require("nvim-lightbulb").setup {
        autocmd = { enabled = true },
      }
    end,
  },

  -- better completion menu
  {
    "xzbdmw/colorful-menu.nvim",
    lazy = false,
    config = function()
      require("colorful-menu").setup {}
    end,
  },

  -- wrapping modes
  {
    "andrewferrier/wrapping.nvim",
    lazy = false,
    config = function()
      require("wrapping").setup()
    end
  },
  -- Misc

  -- save and restore sessions
  {
    "rmagatti/auto-session",
    lazy = false,

    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      git_use_branch_name = true,
      git_auto_restore_on_branch_change = false,
    },
  },

  -- window management
  -- move between nvim & tmix, resize windows/panes ...
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    opts = {
      default_amount = 10,
    },
  },

  {
    "anuvyklack/windows.nvim",
    lazy = false,
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      require("windows").setup()
    end,
  },

  -- auto close buffers when inactive
  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },

  {
    "OXY2DEV/helpview.nvim",
    lazy = false,
  },

  -- todo
  {
    "bngarren/checkmate.nvim",
    ft = "markdown",
    lazy = false,
    opts = {},
  },

  -- PROGRAMMING LANGUAGES
  -- -- json
  {
    "gennaro-tedesco/nvim-jqx",
    event = { "BufReadPost" },
    ft = { "json", "yaml" },
  },
  -- -- go
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    build = function()
      vim.cmd.GoInstallDeps()
    end,
    keys = {
      { "<localleader>e", ":GoIfErr<cr>", desc = "Generate If Eerr" },
    },
  },

  -- -- plantuml
  {
    "aklt/plantuml-syntax",
    ft = { "plantuml" },
  },

  -- -- markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
    config = function()
      require("render-markdown").setup({
        checkbox = {
          enabled = false,
        }
      })
    end,
  },
}
