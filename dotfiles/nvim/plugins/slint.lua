vim.cmd([[ autocmd BufRead,BufNewFile *.slint set filetype=slint ]])

return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		ensure_installed = {
			"slint",
		},
	},
}
