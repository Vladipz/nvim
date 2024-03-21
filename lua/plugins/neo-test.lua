return {
  "nvim-neotest/neotest",
  dependencies = {
    "Issafalcon/neotest-dotnet",
    "nvim-neotest/neotest-python",
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter"
  },
  keys = {
    { "<leader>tr", function() require("neotest").run.run() end,                     desc = "[T]est [R]un" },
    { "<leader>tR", function() require("neotest").run.run(vim.fn.expand("%")) end,   desc = "[T]est [R]UN (all)" },
    { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "[T]est [O]utput" },
    { "<leader>te", function() require("neotest").summary.toggle() end,              desc = "[T]est [E]xplorer" },
    { "<leader>ts", function() require("neotest").output_panel.toggle() end,         desc = "[T]est [S]ummary" },
    { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "[T]est [D]ebug" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-dotnet"),
        require("neotest-python")({runner = "pytest", python = ".venv/Scripts/python.exe",}),
      },
      quickfix = {
        enabled = false,
        open = false,
      },
    })
  end,
}
