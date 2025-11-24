-- cmp setting
local cmp = require "cmp"
local config = cmp.get_config()

table.insert(config.sources, {
  name = "copilot",
  group_index = 2,
})

config.mapping["<TAB>"] = nil
config.mapping["<S-TAB>"] = nil

cmp.setup(config)
