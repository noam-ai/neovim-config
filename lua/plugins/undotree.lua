-- Track undo history in a tree view
return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle [U]ndotree" })

		if vim.fn.has("persistent_undo") then
			local target_path = vim.fn.expand("~/.undodir")

			if not vim.fn.isdirectory(target_path) then
				vim.fn.mkdir(target_path, "p", 0700)
			end

			vim.opt.undodir = target_path
			vim.opt.undofile = true
		end
	end,
}
