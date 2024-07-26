function set_mappings(client, buffer)
  if client.name == "angularls" then
    client.server_capabilities.renameProvider = false
  end
  -- print("Setting mappings for " .. client.name)
  vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { desc = "[D]iagnostic [k] - previous", buffer = buffer })
  vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { desc = "[D]iagnostic [j] - next", buffer = buffer })
  vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, { desc = "[D]iagnostic [O]pen", buffer = buffer })
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
    { desc = "[C]ode [A]ction)", buffer = buffer })
  -- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinition", buffer = buffer })
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[N]ame", buffer = buffer })
  -- vim.keymap.set("n", "<leader>fm", function()
  --   vim.lsp.buf.format({ async = true })
  -- end, { desc = "[F]or[M]at", buffer = buffer })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "K - show info, help", buffer = buffer })
  if client.server_capabilities.signatureHelpProvider then
    require("lsp-overloads").setup(client, {
      display_automatically = false,
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

vim.diagnostic.config({ update_in_insert = true })
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

default_config = {
  capabilities = capabilities,
  on_attach = set_mappings,
  root_dir = function(fname)
    return vim.loop.cwd()
  end,
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


return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ensure_installed = { "lua_ls", "omnisharp", "pyright", "tsserver", "html", "emmet_language_server", "black", "flake8", "mypy", "debugpy", "autoflake", "isort", "sqlls", "sql-formatter" }, 
      })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- "neovim/nvim-lspconfig",
    dependencies = { "mason.nvim",
      "Hoffs/omnisharp-extended-lsp.nvim",
      "Issafalcon/lsp-overloads.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({})
      require("mason-lspconfig").setup_handlers({

        ["omnisharp"] = function()
          require("lspconfig").omnisharp.setup({
            cmd = {
              "dotnet",
              "C:\\Users\\Vlad\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\libexec\\OmniSharp.dll",
            },
            capabilities = capabilities,
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
        end
      })
    end

  }

}
