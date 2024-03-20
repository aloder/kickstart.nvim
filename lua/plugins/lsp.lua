return { {
	'neovim/nvim-lspconfig',
	dependencies = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',

		-- Useful status updates for LSP
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ 'j-hui/fidget.nvim', opts = {} },
		'folke/neodev.nvim',
	},
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "LspInfo", "LspInstall", "LspUninstall" },
	init = function()
		-- mason-lspconfig requires that these setup functions are called in this order
		-- before setting up the servers.
		require('mason').setup()
		require('mason-lspconfig').setup()

		local on_attach = require('plugins.lsp-shared').on_attach
		local servers = {
			clangd = {
				client = {
					cmd = { 'clangd', '--background-index', "--offset-encoding=utf-16", },
					filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
				},
			},

			rust_analyzer = {
				settings = {
					['rust-analyzer'] = {
						assist = {
							importMergeBehavior = 'last',
							importPrefix = 'by_self',
						},
						cargo = {
							loadOutDirsFromCheck = true,
						},
						checkOnSave = {
							command = 'clippy',

						},
						procMacro = {
							enable = true,
						},
					},
				},
			},
			lua_ls = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		}

		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		--
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

		-- Ensure the servers above are installed
		local mason_lspconfig = require 'mason-lspconfig'
		mason_lspconfig.setup {
			ensure_installed = vim.tbl_keys(servers),
		}

		mason_lspconfig.setup_handlers {
			function(server_name)
				require('lspconfig')[server_name].setup {
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name],
					filetypes = (servers[server_name] or {}).filetypes,
				}
			end,
		}
	end

}, require('util').require_if_work("work.plugins.lsp"), }
