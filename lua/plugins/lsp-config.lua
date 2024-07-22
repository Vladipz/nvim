function set_mappings(client, buffer)
  -- print("Setting mappings for " .. client.name)
  vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { desc = "[D]iagnostic [k] - previous", buffer = buffer })
  vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { desc = "[D]iagnostic [j] - next", buffer = buffer })
  vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, { desc = "[D]iagnostic [O]pen", buffer = buffer })
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
    { desc = "[C]ode [A]ction)", buffer = buffer })
  -- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinition", buffer = buffer })
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[N]ame", buffer = buffer })
  vim.keymap.set("n", "<leader>fm", function()
    vim.lsp.buf.format({ async = true })
  end, { desc = "[F]or[M]at", buffer = buffer })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "K - show info, help", buffer = buffer })
  if client.server_capabilities.signatureHelpProvider then
    require("lsp-overloads").setup(client, {
      display_automatically = true,
      ui = {
        border = { " ", "", " ", " ", " ", "", " ", " " },
      },
    })
    vim.keymap.set({ "n", "i" }, "<C-n>", "<cmd>LspOverloadsSignature<CR>",
      { desc = "Ctrl + n - show signature help with overloads (if they are present)", buffer = buffer })
  else
    vim.keymap.set({ "n", "i" }, "<C-n>", vim.lsp.buf.signature_help,
      { desc = "Ctrl + n - show signature help", buffer = buffer })
  end
end

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        PATH = "prepend", -- "skip" seems to cause the spawning error
      --   ensure_installed = { "lua_ls", "omnisharp", "pyright", "tsserver", "html", "emmet_language_server", "black", "flake8", "mypy", "debugpy", "autoflake", "isort", "sqlls", "sql-formatter" },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    "nanotee/sqls.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "omnisharp", "pyright", "tsserver", "html", "emmet_language_server" },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "python" }
    }
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "Hoffs/omnisharp-extended-lsp.nvim",
      "Issafalcon/lsp-overloads.nvim",
    },
    config = function()
      vim.diagnostic.config({ update_in_insert = true })
      local lspconfig = require("lspconfig")
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      default_config = {
        capabilities = capabilities,
        on_attach = set_mappings,
        root_dir = function(fname)
          return vim.loop.cwd()
        end,
      }
      lspconfig.sqlls.setup({
        cmd = { "sql-language-server", "up", "--method", "stdio" },
        filetypes = { "sql", "mysql" },
        root_dir = function() return vim.loop.cwd() end,
        settings = {
          sqlls = {
            connections = {
              {
                dialect = "sqlite",
                name = "SQLite",
                database = ""
              }
            }
          }
        }
      })

            lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.html.setup({
        filetypes = { "html", "htmldjango" },
        -- default_config,
        -- capabilities = capabilities,
      })
      lspconfig.emmet_language_server.setup({
        -- default_config
      })
      lspconfig.pyright.setup({
        on_attach = function(client, buffer)
          set_mappings(client, buffer)
        end,

        settings = {
          pyright = {
            autoImportCompletion = true,
          },
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
              typeCheckingMode = "off",
            },
          },
        },
      })

      lspconfig.tsserver.setup({
        on_attach = function(client, buffer)
          set_mappings(client, buffer)
        end,
        capabilities = capabilities,
      })
      lspconfig.omnisharp.setup({
        on_attach = function(client, buffer)
          set_mappings(client, buffer)
        end,
        cmd = {
          "dotnet",
          "C:\\Users\\vladd\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\libexec\\OmniSharp.dll",
        },
        handlers = {
          ["textDocument/definition"] = require("omnisharp_extended").handler,
        },
        capabilities = capabilities,
        enable_editorconfig_support = true,
        enable_ms_build_load_projects_on_demand = false,
        enable_roslyn_analyzers = true,
        organize_imports_on_format = true,
        enable_import_completion = true,
        sdk_include_prereleases = true,
        analyze_open_documents_only = false,

      })
      vim.diagnostic.config({
        update_in_insert = true,
      })
    end,
  },
}
