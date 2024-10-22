return {
  "folke/todo-comments.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local todo = require("todo-comments")
    todo.setup({
      icons = false,
      highlight = {
        keyword = "bg",
        after = "fg",
      },
      keywords = {
        IDEA = { icon = " ", color = "info" },
      },
    })
    vim.keymap.set("n", "<leader>tk", todo.jump_prev, { desc = "[T]ODO [k] - previous" })
    vim.keymap.set("n", "<leader>tj", todo.jump_next, { desc = "[T]ODO [j] - next" })
    vim.keymap.set("n", "<leader>ta", "<CMD>TodoTelescope<CR>", { desc = "[T]ODO [A]ll" })
  end,
}
