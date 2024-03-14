return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "omnisharp", "pyright" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"Hoffs/omnisharp-extended-lsp.nvim",
			"Issafalcon/lsp-overloads.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.lua_ls.setup({})
			lspconfig.pyright.setup({
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

			lspconfig.omnisharp.setup({
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
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set(
				"n",
				"<leader>gd",
				vim.lsp.buf.definition,
				{ desc = "[G]o to [D]efinition", buffer = buffer }
			)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[N]ame", buffer = buffer })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>fm", function()
				vim.lsp.buf.format({ async = true })
			end, { desc = "[F]or[M]at", buffer = buffer })
			vim.diagnostic.config({
				update_in_insert = true,
			})
		end,
	},
}
