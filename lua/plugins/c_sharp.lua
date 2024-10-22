return {
  "iabdelkareem/csharp.nvim",
  dependencies = {
    "mfussenegger/nvim-dap",
    "Tastyep/structlog.nvim",  -- Optional, but highly recommended for debugging
    "williamboman/mason.nvim", -- Optional, only if you want the plugin to automatically install omnisharp (not needed if you're going to use roslyn lsp)c
  },
  config = function()
    require("mason").setup() -- Mason setup must run before csharp, only if you want to use omnisharp
    require("csharp").setup( -- These are the default values
      {
        lsp = {
          -- Sets if you want to use omnisharp as your LSP
          omnisharp = {
            -- When set to false, csharp.nvim won't launch omnisharp automatically.
            enable = false,
            -- When set, csharp.nvim won't install omnisharp automatically. Instead, the omnisharp instance in the cmd_path will be used.
            cmd_path = "C:\\Users\\Vlad\\AppData\\Local\\omnisharp\\OmniSharp.dll"
          },
          -- The default timeout when communicating with omnisharp
          default_timeout = 1000,
          -- Settings that'll be passed to the omnisharp server
          enable_editor_config_support = true,
          organize_imports = true,
          load_projects_on_demand = false,
          enable_analyzers_support = false,
          enable_import_completion = true,
          include_prerelease_sdks = true,
          analyze_open_documents_only = false,
          enable_package_auto_restore = true,
          -- Launches omnisharp in debug mode
          debug = false,
        }
      })
  end
}
