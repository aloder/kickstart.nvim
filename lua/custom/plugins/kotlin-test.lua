local M = {}
local telescope = require('telescope.builtin')

function M.goto_test_dir()
	local project_root = vim.fn.getcwd()

	-- Define possible test directories for different languages
	local paths = {
		kotlin = project_root .. "/src/test/kotlin",
		cpp = project_root .. "/tests", -- Adjust this as needed for your C++ projects
		java = project_root .. "/src/test/java"
	}

	-- Function to check and open the directory
	local function open_test_dir(test_dir)
		if vim.fn.isdirectory(test_dir) == 1 then
			telescope.find_files({ search_dirs = { test_dir } })
		else
			print("Test directory not found: " .. test_dir)
		end
	end

	-- Logic to determine which directory to open
	-- This is a simple heuristic and might need adjustments based on your projects
	if vim.fn.isdirectory(paths.kotlin) == 1 then
		open_test_dir(paths.kotlin)
	elseif vim.fn.isdirectory(paths.cpp) == 1 then
		open_test_dir(paths.cpp)
	elseif vim.fn.isdirectory(paths.java) == 1 then
		open_test_dir(paths.java)
	else
		print("No known test directory found")
	end
end

return M
