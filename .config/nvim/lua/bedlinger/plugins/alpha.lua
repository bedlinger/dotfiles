return {
	"goolord/alpha-nvim",
	dependencies = {
		"MaximilianLloyd/ascii.nvim",
		"MunifTanjim/nui.nvim",
	},
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local ascii = require("ascii")

		local headers = {
			ascii.get_random("animals", "dogs"),
			ascii.get_random("animals", "cats"),
			ascii.get_random("animals", "pandas"),
			ascii.get_random("animals", "dinosaurs"),
			ascii.get_random("movies", "starwars"),
			ascii.get_random("movies", "toystory"),
			ascii.get_random("computers", "apple"),
			ascii.get_random("misc", "skulls"),
			ascii.get_random("misc", "krakens"),
			ascii.get_random("text", "neovim"),
			ascii.get_random("planets", "planets"),
		}
		local rand_header = headers[math.random(#headers)]

		dashboard.section.header.val = rand_header

		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
			dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("SPC ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
			dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
		}

		alpha.setup(dashboard.opts)

		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
