local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    go = { "gofmt" },
    markdown = { "markdownlint-cli2" },
    json = { "fixjson" },
    groovy = { "npm-groovy-lint" },
  },
  default_format_opts = {
    timeout_ms = 5000,
  },
}

return options
