M = {}
function M.Shared_keybindings()
  vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
  vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })
  vim.keymap.set('n', '<leader>sch', require('telescope.builtin').command_history,
    { desc = '[S]earch [C]ommand [H]istory' })

  vim.keymap.set('n', '<leader>scc', require('telescope.builtin').commands,
    { desc = '[S]earch [C]ommand [C]ommand' })

  vim.keymap.set('n', '<leader>sm', require('telescope.builtin').man_pages,
    { desc = '[S]earch [m]an' })

  vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers,
    { desc = '[S]earch [b]uffers' })

  vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps,
    { desc = '[S]earch [k]eymaps' })

  vim.keymap.set('n', '<leader>:', require('telescope.builtin').commands, { desc = '[S]earch [R]esume' })
end

return M
