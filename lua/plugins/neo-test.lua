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
    { "<leader>tr", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "[T]est [R]un" },
    { "<leader>tR", function() require("neotest").run.run(vim.fn.expand("%")) end,   desc = "[T]est [R]UN (all)" },
    { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "[T]est [O]utput" },
    { "<leader>te", function() require("neotest").summary.toggle() end,              desc = "[T]est [E]xplorer" },
    { "<leader>ts", function() require("neotest").output_panel.toggle() end,         desc = "[T]est [S]ummary" },
    { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "[T]est [D]ebug" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-dotnet")({ {
          -- Extra arguments for nvim-dap configuration
          -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
          dap = { justMyCode = false },
          -- Tell neotest-dotnet to use either solution (requires .sln file) or project (requires .csproj or .fsproj file) as project root
          -- Note: If neovim is opened from the solution root, using the 'project' setting may sometimes find all nested projects, however,
          --       to locate all test projects in the solution more reliably (if a .sln file is present) then 'solution' is better.
          discovery_root = "solution"
        } }),
        require("neotest-python")({ runner = "pytest", python = ".venv/Scripts/python.exe", }),
      },
      output = { open_on_run = true },
      quickfix = {
        enabled = false,
        open = false,
      },
    })
  end,
}
