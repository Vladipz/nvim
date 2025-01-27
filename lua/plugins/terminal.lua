return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
      size = 40,
      direction = 'float',
      open_mapping = [[<c-\>]],
      -- float_opts = {
      --   -- The border key is *almost* the same as 'nvim_open_win'
      --   -- see :h nvim_open_win for details on borders however
      --   -- the 'curved' border is a custom border type
      --   -- -- not natively supported but implemented in this plugin.
      --   -- border = 'single' | 'double' | 'shadow' | 'curved' |
      --   -- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
      --   width = 200,
      --   height = 50,
      --   row = 2,
      --   col = 1,
      --   winblend = 3,
      --
      --   title_pos = 'center',
      -- },
      winbar = {

        name_formatter = function(term) --  term: Terminal
          return term.name
        end
      },
    }
  }
}
