require("lint").linters_by_ft = {
  make = { "checkmake" },
  groovy = { "npm-groovy-lint" },
  yaml = { "yamllint" },
  sh = { "shellharden" },
  bash = { "shellharden" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    local lint_status, lint = pcall(require, "lint")
    if lint_status then
      lint.try_lint()
    end
  end,
})
