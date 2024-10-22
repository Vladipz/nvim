return --Sonarlint
{
  "https://gitlab.com/schrieveslaach/sonarlint.nvim.git",
  config = function()
    require('sonarlint').setup({
      server = {
        cmd = {
          'sonarlint-language-server',
          -- Ensure that sonarlint-language-server uses stdio channel
          '-stdio',
          '-analyzers',
          -- paths to the analyzers you need, using those for python and java in this example
          'C:/Users/Vlad/AppData/Local/nvim-data/mason/packages/sonarlint-language-server/extension/analyzers/sonarlintomnisharp.jar'
          -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarlintomnisharp.jar"),
        }
      },
      filetypes = {
        -- Tested and working
        'csharp',
      }
    })
  end,
}
