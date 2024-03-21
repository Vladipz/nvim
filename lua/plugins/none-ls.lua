return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        require("none-ls.code_actions.eslint"),
        -- require("none-ls.formatting.stylua"),
        --require("none-ls.diagnostics.flake8"),
        --require("none-ls.formatting.black"),
        -- require("none-ls.diagnostics.mypy")
        null_ls.builtins.formatting.black,
        -- null_ls.builtins.diagnostics.flake8,
      }
    })

    vim.keymap.set("n", '<leader>gf', vim.lsp.buf.format, {})
  end,
}
