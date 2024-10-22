local function set_mappings(client, buffer)
  -- NOTE: might remvoe this keymap later
  vim.keymap.set("n", "<leader>oht", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
    { desc = "[O]ther: Inlay [H]ints [T]oggle" })
  vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { desc = "[D]iagnostic [k] - previous", buffer = buffer })
  vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { desc = "[D]iagnostic [j] - next", buffer = buffer })
  vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, { desc = "[D]iagnostic [O]pen", buffer = buffer })
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
    { desc = "[R]e[F]actor (code action)", buffer = buffer })
  vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinition", buffer = buffer })
  vim.keymap.set("n", "<leader>gtd", vim.lsp.buf.type_definition,
    { desc = "[G]o to [T]ype [D]efinition", buffer = buffer })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "K - show info, help", buffer = buffer })
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[N]ame", buffer = buffer })
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
        -- PATH = "skip", -- "skip" seems to cause the spawning error
        -- ensure_installed = { "lua_ls", "omnisharp", "pyright", "tsserver", "html", "emmet_language_server", "black", "flake8", "mypy", "debugpy", "autoflake", "isort", "sqlls", "sql-formatter" },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },

    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "eslint" },
        -- automatic_installation = true
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
    opts = {}
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "Hoffs/omnisharp-extended-lsp.nvim",
      "Issafalcon/lsp-overloads.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local default_config = {
        capabilities = capabilities,
        on_attach = set_mappings,
      }
      local function configure_diagnostic_highlights()
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {})
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {
          underdotted = true,
        })
      end
      local function on_attach(client, buffer)
        set_mappings(client, buffer)
        configure_diagnostic_highlights()
      end

      -- lspconfig.csharp_ls.setup(default_config)
      lspconfig.ts_ls.setup(default_config)
      lspconfig.lua_ls.setup(default_config)
      lspconfig.html.setup(default_config)
      lspconfig.cssls.setup(default_config)
      lspconfig.emmet_ls.setup(default_config)
      lspconfig.css_variables.setup(default_config)
      lspconfig.lemminx.setup(default_config)
      lspconfig.sqlls.setup({
        cmd = { "sql-language-server", "up", "--method", "stdio" },
        filetypes = { "sql", "mysql" },
        root_dir = function() return vim.loop.cwd() end,
      })
      local angularls_path = require("mason-registry").get_package("angular-language-server"):get_install_path()


      local cmd = {
        'ngserver',
        '--stdio',
        '--tsProbeLocations',
        table.concat({
          angularls_path,
          vim.uv.cwd(),
        }, ','),
        '--ngProbeLocations',
        table.concat({
          angularls_path .. '/node_modules/@angular/language-server',
          vim.uv.cwd(),
        }, ','),
      }

      lspconfig.angularls.setup({
        cmd = cmd,
        capabilities = capabilities,
        on_attach = on_attach,
        on_new_config = function(new_config)
          new_config.cmd = cmd
        end,
      })


      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          tailwindCSS = {
            emmetCompletions = true,
          },
        },
      })


      lspconfig.omnisharp.setup({
        cmd = {
          "dotnet",
          "C:\\Users\\Vlad\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\libexec\\OmniSharp.dll",
        },
        -- cmd = {
        --   "dotnet",
        --   "C:\\Users\\Vlad\\AppData\\Local\\omnisharp\\OmniSharp.dll" },
        handlers = {
          ["textDocument/definition"] = require('omnisharp_extended').handler,
        },
        on_attach = on_attach,
        settings = {
          FormattingOptions = {
            EnableEditorConfigSupport = true,
            OrganizeImports = true,
          }
          ,
          RoslynExtensionsOptions = {
            EnableAnalyzersSupport = true,
            EnableImportCompletion = true,
          },
        },
      })
      vim.diagnostic.config({ update_in_insert = true })
    end,
  },
}
