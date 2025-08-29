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
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  "mason-org/mason-lspconfig.nvim",
  lazy = false,
  opts = {
    ensure_installed = {
      "ruff",
      "pylsp",
      "gopls",
      "jsonls",
    },
  },
  dependencies = { { "mason-org/mason.nvim", opts = {} }, "neovim/nvim-lspconfig" },
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
      require("neodim").setup()
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
  {
    "m-demare/hlargs.nvim",
    lazy = false,
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
    }, -- for default options, refer to the configuration section for custom setup.
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
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
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
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
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
    end,
  },
  {
    "ggandor/flit.nvim",
    lazy = false,
    config = function()
      require("flit").setup {}
    end,
  },
  {
    "abecodes/tabout.nvim",
    lazy = false,
    config = function()
      require("tabout").setup {
        tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = "<C-d>", -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = false, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      }
    end,
    dependencies = { -- These are optional
      "nvim-treesitter/nvim-treesitter",
      "L3MON4D3/LuaSnip",
      "hrsh7th/nvim-cmp",
    },
    opt = false, -- Set this to true if the plugin is optional
    event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
    priority = 1000,
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
      leader_key = ";", -- Recommended to be a single key
      buffer_leader_key = "m", -- Per Buffer Mappings
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
          default = { "imports", "comment" },
        },
      }
    end,
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
      { "<leader>A", "<cmd>AerialNavToggle<CR>", desc = "Aerial Nav Toggle" },
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
      { "<leader>oo", "<cmd>:Other<CR>", desc = "[o]pen [o]ther file" },
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
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- disable inc-rename
        lsp_doc_border = true, -- add a border to hover docs and signature help
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
  -- Misc
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "Octo" },
    config = function()
      require("octo").setup()
    end,
  },

  {
    "shortcuts/no-neck-pain.nvim",
    keys = {
      { "<leader>pn", ":NoNeckPain<CR>", desc = "Toggle No Neck Pain", noremap = true, silent = true },
      { "<leader>ps", ":NoNeckPainScratchPad<CR>", desc = "Open Scratch Pad", noremap = true, silent = true },
    },
    config = function()
      require("no-neck-pain").setup {
        buffers = {
          scratchPad = {
            -- set to `false` to
            -- disable auto-saving
            enabled = true,
            -- set to `nil` to default
            -- to current working directory
            location = nil,
          },
          bo = {
            filetype = "md",
          },
        },
      }
    end,
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
  -- move between nvim & tmix, resize windows/panes ...
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    opts = {
      default_amount = 10,
    },
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
    cmd = { "GoInstallDeps", "GoUpdateBinaries" },
    -- branch = "develop"
    -- (optional) will update plugin's deps on every update
    build = function()
      vim.cmd.GoInstallDeps()
    end,

    ---@type gopher.Config
    opts = {},
    keys = {
      { "<localleader>e", ":GoIfErr<cr>", desc = "Generate If Eerr" },
    },
  },
}
