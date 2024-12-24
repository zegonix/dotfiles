-- Set lualine as statusline
return {
	"nvim-lualine/lualine.nvim",
	config = function()
		-- Adapted from: https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/themes/onedark.lua
		local colors = {
			black = "#181820",
			red = "#E00010",
			green = "#34AD1F",
			yellow = "#E1D719",
			blue = "#2B58D4",
			magenta = "#E02482",
			purple = "#9018E0",
			cyan = "#15D7E5",
			white = "#E0E0E0",
			dim_black = "#2C2C3C",
			dim_red = "#FF4054",
			dim_green = "#51E740",
			dim_yellow = "#E8DC80",
			dim_blue = "#709FE3",
			dim_magenta = "#FBB0DD",
			dim_cyan = "#60D7E1",
			dim_white = "#C0C0C0",
			fg = "#E0E0E0",
			bg = "#181820",
			gray1 = "#54546D",
			gray2 = "#2A2A37",
			gray3 = "#363646",
		}

		local kanagawa_paper = {
			normal = {
				a = { fg = colors.bg, bg = colors.dim_red, gui = "bold" },
				b = { fg = colors.fg, bg = colors.gray3 },
				c = { fg = colors.fg, bg = colors.bg },
			},
			command = { a = { fg = colors.bg, bg = colors.yellow, gui = "bold" } },
			insert = { a = { fg = colors.bg, bg = colors.blue, gui = "bold" } },
			visual = { a = { fg = colors.bg, bg = colors.purple, gui = "bold" } },
			terminal = { a = { fg = colors.bg, bg = colors.cyan, gui = "bold" } },
			replace = { a = { fg = colors.bg, bg = colors.dim_red, gui = "bold" } },
			inactive = {
				a = { fg = colors.gray1, bg = colors.bg, gui = "bold" },
				b = { fg = colors.gray1, bg = colors.bg },
				c = { fg = colors.gray1, bg = colors.gray2 },
			},
		}

		local mama_mia = {
			normal = {
				a = { fg = colors.bg, bg = colors.dim_blue, gui = "bold" },
				b = { fg = colors.fg, bg = colors.gray3 },
				c = { fg = colors.fg, bg = colors.bg },
			},
			command = { a = { fg = colors.bg, bg = colors.dim_yellow, gui = "bold" } },
			insert = { a = { fg = colors.bg, bg = colors.dim_magenta, gui = "bold" } },
			visual = { a = { fg = colors.bg, bg = colors.dim_cyan, gui = "bold" } },
			terminal = { a = { fg = colors.bg, bg = colors.cyan, gui = "bold" } },
			replace = { a = { fg = colors.bg, bg = colors.red1, gui = "bold" } },
			inactive = {
				a = { fg = colors.gray1, bg = colors.bg, gui = "bold" },
				b = { fg = colors.gray1, bg = colors.bg },
				c = { fg = colors.gray1, bg = colors.gray2 },
			},
		}

		--	local kanagawa_paper = require("themes.kanagawa-paper")
		-- Import color theme based on environment variable NVIM_THEME
		local env_var_nvim_theme = "mama_mia"

		-- Define a table of themes
		local themes = {
			kanagawa_paper = kanagawa_paper,
			mama_mia = mama_mia,
		}

		local mode = {
			"mode",
			fmt = function(str)
				return str
			end,
		}

		local filename = {
			"filename",
			file_status = true, -- displays file status (readonly status, modified status)
			path = 0,  -- 0 = just filename, 1 = relative path, 2 = absolute path
		}

		local hide_in_width = function()
			return vim.fn.winwidth(0) > 100
		end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
			colored = false,
			update_in_insert = false,
			always_visible = false,
			cond = hide_in_width,
		}

		local diff = {
			"diff",
			colored = false,
			symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
			cond = hide_in_width,
		}

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = themes[env_var_nvim_theme], -- Set theme based on environment variable
				-- Some useful glyphs:
				-- https://www.nerdfonts.com/cheat-sheet
				--        
				section_separators = { left = "", right = "" },
				component_separators = { left = ":", right = ":" },
				disabled_filetypes = { "alpha", "neo-tree", "Avante" },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { "branch" },
				lualine_c = { filename },
				lualine_x = {
					diagnostics,
					--diff,
					{ "encoding", cond = hide_in_width },
					{ "filetype", cond = hide_in_width },
				},
				lualine_y = { "location" },
				lualine_z = { "progress" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { { "location", padding = 0 } },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_a = { "buffers" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},

			extensions = { "fugitive" },
		})
	end,
}
