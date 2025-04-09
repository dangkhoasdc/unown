local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    go = { "gofmt" },
  },
}

return options
