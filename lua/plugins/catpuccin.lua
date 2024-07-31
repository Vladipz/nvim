return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function()
    require("catppuccin").setup {
      custom_highlights = function(C)
        return {
          ["@property.class"] = { fg = C.yellow },
          ["@property.css"] = { fg = C.blue },
          ["@property.scss"] = { fg = C.blue },
          ["@variable"] = { fg = C.blue },
        }
      end
    }
    vim.cmd.colorschem "catppuccin-macchiato"
  end
}
