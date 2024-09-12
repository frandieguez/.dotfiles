return {
	{
		"romgrk/github-light.vim",
	},
	{
		"sainnhe/sonokai",
		priority = 1000,
		config = function()
			vim.g.sonokai_transparent_background = "1"
			vim.g.sonokai_enable_italic = "1"
			vim.g.sonokai_style = "andromeda"
			vim.cmd.colorscheme("sonokai")
		end,
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "sonokai",
		},
	},
	-- {
	-- 	"f-person/auto-dark-mode.nvim",
	-- 	opts = {
	-- 		set_dark_mode = function()
	-- 			vim.api.nvim_set_option_value("background", "dark", {})
	-- 			vim.cmd("colorscheme sonokai")
	-- 		end,
	-- 		set_light_mode = function()
	-- 			vim.api.nvim_set_option_value("background", "light", {})
	-- 			vim.cmd("colorscheme github-light")
	-- 		end,
	-- 	},
	-- },
}
