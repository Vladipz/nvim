return { {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = { 'nvim-lua/plenary.nvim' },

    keys = {
        { "<leader><leader>", function() require("telescope.builtin").buffers() end, desc = "Space + Space - find buffers for quick access" },
        { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "[F]ind [F]iles" },
        { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "[F]ind [B]uffers" },
        { "<leader>fw", function() require("telescope.builtin").grep_string() end, desc = "[F]ind [W]ord (under cursor)" },
        { "<leader>fc", function() require("telescope.builtin").live_grep() end, desc = "[F]ind [C]ontents" },
        { "<leader>fg", function() require("telescope.builtin").git_files() end, desc = "[F]ind in [G]it" },
        { "<leader>da", function() require("telescope.builtin").diagnostics() end, desc = "[D]iagnostics [A]ll" },
        { "<leader>gi", function() require("telescope.builtin").lsp_implementations() end, desc = "[G]o to [I]mplementations" },
        { "<leader>gr", function() require("telescope.builtin").lsp_references() end, desc = "[G]o to [R]eferences" },
        { "<leader>cs", function() require("telescope.builtin").colorscheme() end, desc = "[C]olor[S]cheme" },
      },
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set('n', '<C-p>', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, {})

    --vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations(), {})

  end
},
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }

          }
        }
      }
      require("telescope").load_extension("ui-select")
    end
  }
}
