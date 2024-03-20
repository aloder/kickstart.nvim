return {
  -- LSP Configuration & Plugins
  --   -- Autocompletion
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',
    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',
    "hrsh7th/cmp-omni",

    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',

  },
  init = function()
    -- [[ Configure nvim-cmp ]]
    -- See `:help cmp`
    local cmp = require 'cmp'
    local cmp_select = {behavior = cmp.SelectBehavior.Select}
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    local function border(hl_name)
      return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
      }
    end
    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noselect'
      },

      window = {
        completion = {
          scrollbar = true,
          border = border "CmpBorder",
        },
        documentation = {
          border = border "CmpDocBorder",
        },
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Tab>"] = nil,
        ["<S-Tab>"] = nil,
        ["<CR>"] = nil,
      },

      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'copilot' },
        { name = 'vim-dadbod-completion' },
        { name = 'crates' },
        { name = "path",                 option = { trailing_slash = true } },
      },
    }
    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })
  end,

}
-- vim: ts=2 sts=2 sw=2 et
