return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				markdown = { "prettierd" },
				md = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
				scss = { "prettierd" },
				rust = { "rustfmt", lsp_format = "fallback" },
				javascript = { "tsserver", "prettierd", stop_after_first = true },
				typescript = { "tsserver", "prettierd", stop_after_first = true },
				javascriptreact = { "tsserver", "prettierd", stop_after_first = true },
				typescriptreact = { "tsserver", "prettierd", stop_after_first = true },
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
