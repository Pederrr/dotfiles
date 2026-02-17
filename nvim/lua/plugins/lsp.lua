return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',
		},
		config = function()
			vim.api.nvim_create_autocmd('LspAttach', {
				-- group = vim.api.nvim_create_augrup('kickstart-lsp-attach', { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
					end

					map('K', vim.lsp.buf.hover, 'Hover Documentation')

					map('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
					map('<leader>f', vim.lsp.buf.format, '[f]ormatting')

					map('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction')

					map('<C-k>', vim.lsp.buf.signature_help, 'Signature help')
					map('<leader>D', vim.lsp.buf.type_definition, 'type [d]efinition')

					map('<leader>e', vim.diagnostic.open_float, 'Open diagnostic in float')
					map('[d', vim.diagnostic.goto_prev, 'goto previous diagnostic')
					map(']d', vim.diagnostic.goto_next, 'goto next diagnostic')
				end,
			})


			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

			local servers = {
				pylsp = {
					settings = {
						pylsp = {
							pluggins = {
								ruff = {
									enabled = true,
									formatEnabled = true,
									format = { "I" },
								},
								pylsp_mypy = { enabled = true },
							}
						}
					}
				},
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"-j=16",
						"--query-driver=/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
						"--clang-tidy",
						"--clang-tidy-checks=*",
						"--all-scopes-completion",
						"--cross-file-rename",
						"--completion-style=detailed",
						"--header-insertion-decorators",
						"--header-insertion=iwyu",
					}
				},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
								buildScripts = {
									enable = true
								}
							},
							checkOnSave = {
								command = "clippy"
							}
						}
					}
				},
				hls = {},
				lua_ls = {},
				solargraph = {}, -- Ruby
				ts_ls = {}, -- TypeScript
			}

			require('mason').setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				'ruff' -- used for Python formatting and linting
			})
			require('mason-lspconfig').setup { ensure_installed = ensure_installed }
			require('mason-lspconfig').setup {
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
						vim.lsp.enable(server_name)
						vim.lsp.config(server_name, server)
					end,
				}
			}

			-- autoformat
			vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
		end,
	}
}
