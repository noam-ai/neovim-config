-- Github Copilot configuration
return {
	"github/copilot.vim",
	opts = {
		copilot_filetypes = {
			-- To Add mode filetypes add: 'type': true
		},
	},
	config = function()
		vim.g.copilot_no_tab_map = true
		vim.keymap.set(
			"i",
			"<C-Y>",
			"copilot#Accept('\\<CR>')",
			{ desc = "Accept Copilot suggestion", expr = true, replace_keycodes = false }
		)
	end,
}
