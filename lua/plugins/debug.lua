return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',

    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    require('dap.ext.vscode').load_launchjs(nil, { cppdbg = { 'c', 'cpp' } })
    dap.adapters.lldb = {
      type = "executable",
      name = "lldb",
      command = "lldb-vscode",
    }

    dap.adapters.cppdbg = {
      type = "executable",
      name = "lldb-cppdbg",
      command = "lldb-vscode",
    }

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        MIMode = 'lldb',
        stopAtEntry = true,
      },
    }
    dap.configurations.c = dap.configurations.cpp
    local continue = function()
      if vim.fn.filereadable('.vscode/launch.json') then
        require('dap.ext.vscode').load_launchjs(nil, { cppdbg = { 'c', 'cpp' } })
      end
      require('dap').continue()
    end
    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<F12>', dap.terminate, { desc = 'Debug: Close' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()
  end,
}
