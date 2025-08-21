-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- Global setting
-- -- Foldng
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
  require("lspconfig")[ls].setup {
    capabilities = capabilities,
    -- you can add other fields for setting up lsp server in this table
  }
end

require("ufo").setup()

-- lsps with default config
local servers =
  { "pylsp", "gopls", "dockerls", "julials", "ruff", "jsonls", "groovyls", "yamlls", "rust_analyzer", "vacuum" }
local nvlsp = require "nvchad.configs.lspconfig"
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.gopls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    gopls = {
      gofumpt = false,
    },
  },
}

lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        pyflakes = {
          enabled = false,
        },
        pycodestyle = {
          enabled = false,
        },
      },
    },
  },
}

lspconfig.groovyls.setup {
  cmd = { "groovy-language-server" },
  filetypes = { "groovy" },
}
