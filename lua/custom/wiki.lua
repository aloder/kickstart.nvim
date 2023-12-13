local M = {}

function M.pages(opts)
	builtin.find_files(vim.tbl_deep_extend("force", {
		prompt_title = "Wiki files",
		cwd = vim.fn["wiki#get_root"](),
		file_ignore_patterns = {
			"%.stversions/",
			"%.git/",
		},
		path_display = function(_, path)
			local name = path:match "(.+)%.[^.]+$"
			return name or path
		end,
		attach_mappings = function(prompt_bufnr, _)
			actions.select_default:replace_if(function()
				return action_state.get_selected_entry() == nil
			end, function()
				actions.close(prompt_bufnr)
				local new_name = action_state.get_current_line()
				if vim.fn.empty(new_name) ~= 1 then
					return
				end
				vim.fn["wiki#page#open"](new_name)
			end)
			return true
		end,
	}, opts or {}))
end

return M
