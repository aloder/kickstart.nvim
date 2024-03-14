return {
  require("plugins.telescope"),
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },

    init = function()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

      vim.keymap.set("n", "<leader>.", "<CMD>Oil<CR>")
    end,
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    init = function()
      -- [[ Configure Aerial ]]
      require("aerial").setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      })
      -- You probably also want to set a keymap to toggle aerial
      vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle!<CR>")
    end
  },
  {
    'ThePrimeagen/harpoon',
    init = function()
      require('harpoon').setup({})
      local mark = require("harpoon.mark")
      vim.keymap.set("n", "<leader>hm", mark.add_file, { desc = "Harpoon: Add File" })

      local ui = require("harpoon.ui")
      vim.keymap.set("n", "<leader>hd", mark.rm_file, { desc = "Harpoon: Remove current file" })
      vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu, { desc = "Harpoon: UI quick menu" })

      vim.keymap.set("n", "<C-p>", ui.nav_prev, { desc = "Harpoon: Prev file" })
      vim.keymap.set("n", "<C-n>", ui.nav_next, { desc = "Harpoon: Next file" })
      for i = 1, 9 do
        local open_file = function()
          ui.nav_file(i)
        end
        vim.keymap.set('n', '<leader>h' .. i, open_file, { desc = 'Harpoon: Open file ' .. i })
      end
      local telescope = require("telescope")
      telescope.load_extension("harpoon")
      vim.keymap.set("n", "<leader>hs", ":Telescope harpoon marks<CR>", { desc = "Harpoon: search" })
    end
  },
}
