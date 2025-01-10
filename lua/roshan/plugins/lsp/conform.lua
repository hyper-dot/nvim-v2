return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				markdown = { "prettierd" },
				md = { "prettierd" },
				rust = { "rustfmt", lsp_format = "fallback" },
				javascript = { "typescript-language-server", "prettierd", stop_after_first = true },
				typescript = { "typescript-language-server", "prettierd", stop_after_first = true },
				javascriptreact = { "typescript-language-server", "prettierd", stop_after_first = true },
				typescriptreact = { "typescript-language-server", "prettierd", stop_after_first = true },
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})

		vim.lsp.buf.format({
			filter = function(client)
				return client.name ~= "tsserver"
			end,
		})
	end,
}
