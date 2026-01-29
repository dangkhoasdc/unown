-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local servers = {
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          pyflakes = {
            enabled = false,
          },
          pycodestyle = {
            enabled = false,
          },
          autopep8 = {
            enabled = false,
          },
          flake8 = {
            enabled = false,
          },
          mccabe = {
            enabled = false,
          },
          rope_autoimport = {
            enabled = true
          }
        },
      },
      signature = {
        formatter = 'ruff'
      },
    },
  },
  gopls = {
    settings = {
      gopls = {
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
        gofumpt = false,
      },
    },
  },
  dockerls = {},
  ruff = {
    init_options = {
      settings = {
        lint = {
          enable = true
        },
        format = {
          preview = true
        }
      },
    }
  },
  jsonls = {},
  groovyls = {
    cmd = { "groovy-language-server" },
    filetypes = { "groovy" },
  },
  yamlls = {},
  rust_analyzer = {},
  vacuum = {},
  bashls = {},
  just = {},
  marksman = {},
  serve_d = {},
}


for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end

-- Global setting
-- -- Foldng
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
