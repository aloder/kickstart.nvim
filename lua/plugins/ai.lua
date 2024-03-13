return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    enabled = not MyConfig.work,
    opts = {
      enabled = false,
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        help = true,
      },
    },
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-l>",
          }
        },
      })
    end
  },
}
