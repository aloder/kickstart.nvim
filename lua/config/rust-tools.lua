local rt = require("rust-tools")
local options = {
	server = {
		on_attach = function(_, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<Leader>rh", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>ra", rt.code_action_group.code_action_group, { buffer = bufnr })

			vim.keymap.set("n", "<Leader>ra", rt.open_cargo_toml.open_cargo_toml, { buffer = bufnr })

			vim.keymap.set("n", "<Leader>rr", ":RustRun<CR>", { buffer = bufnr })
		end,
	}
}

return options
