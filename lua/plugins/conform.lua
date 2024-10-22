return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        html = { "prettier" },
        cshtml = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        scss = { "prettier" },
        sql = { 'sql_formatter' }
      },
    })

    vim.keymap.set("n", "<leader>fm", function()
      conform.format({
        timeout_ms = 3000,
        lsp_fallback = true,
      })
    end)
  end
}
