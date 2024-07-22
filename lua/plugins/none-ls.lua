return {
  -- "nvimtools/none-ls.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  -- dependencies = {
  --   "nvimtools/none-ls-extras.nvim",
  -- },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- require("none-ls.code_actions.eslint"),
        -- require("none-ls.diagnostics.ruff"),
        -- require("none-ls.formatting.stylua"),
        --require("none-ls.diagnostics.flake8"),
        --require("none-ls.formatting.black"),
        -- require("none-ls.diagnostics.mypy")
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.flake8.with({
          prefer_local = ".venv/bin",
          extra_args = { "--max-line-length", "88", "--ignore", "F401" }
        }),
        null_ls.builtins.formatting.sql_formatter, -- null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.diagnostics.flake8,
        -- null_ls.builtins.diagnostics.flake8,
      }
    })

    vim.keymap.set("n", '<leader>gf', vim.lsp.buf.format, {})
  end,
}
