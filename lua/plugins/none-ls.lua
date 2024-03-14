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
        null_ls.builtins.formatting.stylua,
      }
    })

    vim.keymap.set("n", '<leader>gf', vim.lsp.buf.format, {})
  end,
}
