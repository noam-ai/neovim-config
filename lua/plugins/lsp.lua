-- LSP Servers

local python_servers = {
	pyright = {
		-- Using Ruff's import organizer
		settings = {
			disableOrganizeImports = true,
		},
	},
	ruff = {
		trace = "messages",
	},
}

local web_servers = {
	ts_ls = {},
	templ = {
		filetypes = { "templ" },
	},
	html = {
		filetypes = { "html", "templ" },
	},
	htmx = {
		filetypes = { "html", "templ" },
	},
}

local go_servers = {
	gopls = {
		settings = {
			gopls = {
				analysis = {
					unusedparams = true,
					shadow = true,
				},
				staticcheck = true,
			},
		},
	},
}

local lua_servers = {
	lua_ls = {

		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				workspace = {
					checkThirdParty = false,
					-- Tells lua_ls where to find all the Lua files that you have loaded
					-- for your neovim configuration.
					library = {
						"${3rd}/luv/library",
						unpack(vim.api.nvim_get_runtime_file("", true)),
					},
					-- If lua_ls is really slow on your computer, you can try this instead:
					-- library = { vim.env.VIMRUNTIME },
				},
				completion = {
					callSnippet = "Replace",
				},
				-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
				-- diagnostics = { disable = { 'missing-fields' } },
			},
		},
	},
}

local function get_servers()
	return {
		-- Python
		unpack(python_servers),

		-- Web
		unpack(web_servers),

		-- Go
		unpack(go_servers),

		-- Lua
		unpack(lua_servers),
	}
end

local function disable_ruff_hover(args)
	local client = vim.lsp.get_client_by_id(args.data.client_id)
	if client == nil then
		return
	end
	if client.name == "ruff" then
		-- Disable hover in favor of Pyright
		client.server_capabilities.hoverProvider = false
	end
end

-- LSP Configuration & Plugins
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			end,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
			callback = disable_ruff_hover,
			desc = "LSP: Disable hover capability from Ruff",
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		require("mason").setup()

		local servers = get_servers(capabilities)
		local ensure_installed = vim.tbl_keys(servers or {})

		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
