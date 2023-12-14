return { { -- markdown image
	-- PasteImg
	"postfen/clipboard-image.nvim",
	-- Upstream is "ekickx/clipboard-image.nvim",
	-- Context for fork: https://github.com/ekickx/clipboard-image.nvim/pull/48#issuecomment-1589760763
	lazy = true,
	cmd = { "PasteImg" },
	opts = {
		default = {
			img_dir = "Media",
			-- https://github.com/ekickx/clipboard-image.nvim/discussions/15#discussioncomment-1638740
			img_name = function()
				vim.fn.inputsave()
				local name = vim.fn.input("Name: ")
				vim.fn.inputrestore()
				return name
			end,
		},
	},
},
	{ -- headlines
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		lazy = true,
		event = {
			"BufReadPre **.md",
			"BufNewFile **.md",
		},
		opts = {
			markdown = {
				-- Termux doesn't display the characters well
				-- fat_headlines = is_android(),

				fat_headlines = false,

				headline_highlights = {
					"DiffDelete",
					"DiffAdd",
					"Headline",
				},
				-- codeblock_highlight = "DiffChange",
				-- Differentiates it a bit from code block
				-- headline_highlights = {
				--   "DiagnosticVirtualTextError",
				--   "DiagnosticVirtualTextInfo",
				--   "DiagnosticVirtualTextWarn",
				--   "CursorLine",
				-- },

				dash_string = "─",
			},
		},
		config = true, -- or `opts = {}`
	}, {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
	--   "BufReadPre path/to/my-vault/**.md",
	--   "BufNewFile path/to/my-vault/**.md",
	-- },
	--
	cmd = {
		"ObsidianToday",
		"ObsidianTomorrow",
		"ObsidianSearch",
		"ObsidianWorkspace",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/docs/brain",
			},
			{
				name = "work",
				path = "~/vaults/work",
			},
		},

	},
	ui = {
		checkboxes = {
			-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
			[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
			["x"] = { char = "", hl_group = "ObsidianDone" },
			[">"] = { char = "", hl_group = "ObsidianRightArrow" },
			["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
			["/"] = { char = "󰡖", hl_group = "ObsidianDone" },
		},
	},
	config = function(_, opts)
		require("obsidian").setup(opts)

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("obsidian_keybindings", { clear = true }),
			pattern = { "markdown" },
			callback = function(event)
				-- event = { buf, event, file, group, id, match }
				vim.keymap.set(
					"n",
					"<leader>wr",
					"<cmd>ObsidianBacklinks<CR>",
					{ buffer = event.buf, desc = "Obsidian: Show backlinks" }
				)
				vim.keymap.set("n", "<leader>wR", function()
					local current_name = vim.fn.expand("%:t:r")
					local new_name = vim.fn.input("New name: ", current_name, "file")
					if new_name == "" then
						return
					end
					vim.cmd("ObsidianRename " .. new_name)
				end, { buffer = event.buf, desc = "Obsidian: Rename..." })
				vim.keymap.set(
					"n",
					"gr",
					"<cmd>ObsidianBacklinks<CR>",
					{ buffer = event.buf, desc = "Obsidian: Show backlinks" }
				)
				-- vim.keymap.set(
				--   "n",
				--   "<c-p>",
				--   "<cmd>ObsidianQuickSwitch<CR>",
				--   { buffer = event.buf, desc = "Obsidian: Open..." }
				-- )
				vim.keymap.set(
					"n",
					"<leader>ws",
					"<cmd>ObsidianQuickSwitch<CR>",
					{ buffer = event.buf, desc = "Obsidian: Open..." }
				)
				vim.keymap.set(
					"n",
					"<leader>w/",
					"<cmd>ObsidianSearch<CR>",
					{ buffer = event.buf, desc = "Obsidian: Search..." }
				)
				vim.keymap.set(
					"n",
					"gf",
					"<cmd>ObsidianFollowLink<CR>",
					{ buffer = event.buf, desc = "Obsidian: Follow link" }
				)
			end,
		})
	end,
}, }
