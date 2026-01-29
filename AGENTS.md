# AGENTS.md - Neovim Configuration

This is a Lua-based Neovim configuration built on **NvChad v2.5**. It uses lazy.nvim
for plugin management and includes 87+ plugins for LSP, completion, formatting, and AI assistance.

## Project Structure

```
lua/
  init.lua              # Entry point (bootstraps lazy.nvim)
  chadrc.lua            # NvChad theme/UI configuration
  options.lua           # Vim options, filetype detection
  autocmds.lua          # Autocommands
  mappings.lua          # Key mappings
  configs/              # Plugin-specific configurations
    cmp.lua             # nvim-cmp completion config
    conform.lua         # Formatter configuration
    lazy.lua            # lazy.nvim settings
    lspconfig.lua       # LSP server configurations
    nvim-lint.lua       # Linter configuration
    nvtree.lua          # nvim-tree file explorer
  plugins/
    init.lua            # All plugin specifications (~766 lines)
```

## Build/Lint/Test Commands

### Formatting (StyLua)

```bash
# Format all Lua files
stylua lua/

# Format a single file
stylua lua/plugins/init.lua

# Check formatting without changes
stylua --check lua/
```

### Linting

No Lua linting is configured for this config (no .luacheckrc or selene.toml).
Consider using luacheck or selene for static analysis.

### Plugin Management

```bash
# Sync plugins (headless)
nvim --headless -c "Lazy! sync" -c "qa"

# Or use the justfile
just sync
```

### Testing

No test framework is configured. For testing Neovim plugins, consider:
- plenary.nvim for async testing
- busted for unit tests

## Code Style Guidelines

### StyLua Configuration (.stylua.toml)

```toml
column_width = 120
line_endings = "Unix"
indent_type = "Spaces"
indent_width = 2
quote_style = "AutoPreferDouble"
call_parentheses = "None"
```

### Formatting Rules

- **Indentation**: 2 spaces (never tabs)
- **Line width**: 120 characters max
- **Quotes**: Double quotes preferred (`"string"`)
- **Function calls**: Omit parentheses where possible (`require "module"`)
- **Line endings**: Unix (LF)
- **Trailing whitespace**: Automatically trimmed (trim.nvim)

### Imports and Requires

```lua
-- Use space-separated require (no parentheses)
require "nvchad.mappings"
require "configs.lspconfig"

-- For requires with assignments, use parentheses
local builtin = require "telescope.builtin"
local map = vim.keymap.set
```

### Naming Conventions

- **Variables**: `snake_case` for locals (`local lazy_config = ...`)
- **Module tables**: PascalCase M (`local M = {}`)
- **Plugin specs**: Use descriptive table keys
- **Keymaps**: Include `desc` field for which-key integration

### Plugin Specification Pattern

```lua
{
  "author/plugin-name",
  lazy = false,                    -- or event/cmd/ft for lazy loading
  dependencies = { "dep/plugin" },
  opts = { ... },                  -- or config = function() ... end
  keys = {
    { "<leader>x", "<cmd>Cmd<cr>", desc = "Description" },
  },
},
```

### Keymap Conventions

```lua
-- Use vim.keymap.set with descriptive options
map("n", "<leader>xx", function()
  -- implementation
end, { desc = "[X] Description", noremap = true, silent = true })

-- Description format: Use brackets for mnemonics [F]ind [S]ymbols
```

### Leader Keys

- **Leader**: `<Space>`
- **Local Leader**: `,`

## Error Handling

```lua
-- Use pcall for optional requires
local status, module = pcall(require, "optional-module")
if status then
  module.setup()
end

-- For plugin configs, rely on lazy.nvim's error handling
config = function()
  require("plugin").setup { ... }
end
```

## LSP Configuration Pattern

LSP servers are configured in `lua/configs/lspconfig.lua`:

```lua
local servers = {
  server_name = {
    settings = { ... },
  },
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
```

### Configured LSP Servers

pylsp, gopls, dockerls, ruff, jsonls, groovyls, yamlls,
rust_analyzer, vacuum, bashls, just, marksman, serve_d

## Formatters (conform.nvim)

| Language   | Formatter(s)                              |
|------------|-------------------------------------------|
| Python     | ruff_fix, ruff_format, ruff_organize_imports |
| Go         | gofmt                                     |
| Markdown   | markdownlint-cli2                         |
| JSON       | fixjson                                   |
| Groovy     | npm-groovy-lint                           |
| YAML       | yamlfmt                                   |
| Rust       | rustfmt                                   |
| Bash/sh    | shellharden                               |

## Linters (nvim-lint)

| Language   | Linter         |
|------------|----------------|
| Make       | checkmake      |
| Groovy     | npm-groovy-lint|
| YAML       | yamllint       |
| Bash/sh    | shellharden    |

## Important Patterns

### Adding New Plugins

Add plugin specs to `lua/plugins/init.lua`:

```lua
{
  "author/new-plugin",
  event = "VeryLazy",  -- lazy load
  opts = {},
},
```

### Adding Keymaps

Add to `lua/mappings.lua`:

```lua
map("n", "<leader>key", function()
  -- action
end, { desc = "Description" })
```

### Custom Filetypes

Configure in `lua/options.lua` using `vim.filetype.add`:

```lua
vim.filetype.add {
  extension = { ext = "filetype" },
  filename = { ["filename"] = "filetype" },
  pattern = { ["pattern"] = "filetype" },
}
```

## Dependencies

- **NvChad v2.5**: Base framework
- **lazy.nvim**: Plugin manager (bootstrapped in init.lua)
- **Mason**: LSP/DAP/Linter/Formatter installer
- **Treesitter**: Syntax highlighting and code parsing
