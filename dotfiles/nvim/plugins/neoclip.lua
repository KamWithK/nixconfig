return {
	"AckslD/nvim-neoclip.lua",
	version = "*",
	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
	},
	init = function()
		require("neoclip").setup()
	end,
	keys = {
		{ "<leader>o", "<cmd>Telescope neoclip<CR>", desc = "Neoclip" },
	},
}
