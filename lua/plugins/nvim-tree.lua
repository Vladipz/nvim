return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>fe", vim.cmd.NvimTreeToggle, desc = "[F]ile [E]xplorer" },
  },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  opts = {
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
  },
}
