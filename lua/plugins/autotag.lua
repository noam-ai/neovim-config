return {
	"windwp/nvim-ts-autotag",
	config = function()
		require("nvim-ts-autotag").setup({
			filetypes = {
				"html",
				"xml",
				"javascriptreact",
				"typescriptreact",
				"svelte",
				"vue",
				"tsx",
				"jsx",
			},
			enable_close_on_slash = true,
		})
	end,
}
