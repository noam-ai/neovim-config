-- Organize stuff in a table
return {
	"godlygeek/tabular",
	config = function()
		vim.keymap.set("v", "<leader>t", ":Tabularize /=<CR>", { desc = "Align to =" })
	end,
}
