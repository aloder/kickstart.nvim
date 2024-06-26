MyConfig = require('config')
require('vim-config')
require('load-lazy')
local util = require('util')

require('lazy').setup({
  require 'plugins.alpha',
  require 'plugins.treesitter',
  require 'plugins.dadbod',
  require 'plugins.autoformat',
  require 'plugins.debug',
  require 'plugins.git',
  require 'plugins.search',
  require 'plugins.ui',
  require 'plugins.lsp',
  require 'plugins.cmp',
  require 'plugins.rust',
  require 'plugins.ai',
  require 'plugins.zenmode',
  'ziglang/zig.vim',
  'codethread/qmk.nvim',
  util.require_if_work('work.plugins'),
}, {})


require('vim-todo-file')
util.require_if_work('work.config')
-- vim: ts=2 sts=2 sw=2 et
