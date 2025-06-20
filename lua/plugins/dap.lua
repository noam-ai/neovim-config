return {
	{
		'mfussenegger/nvim-dap',
		config = function ()
			local dap = require('dap')

			-- Setup Python debugging
			dap.adapters.python = function (callback, config)
				if config.request == 'attach' then
					local port = (config.connect or config).port
					local host = (config.connect or config).host or '127.0.0.1'
					callback({
						type = 'server',
						port = assert(port, '`connect.port` is required for a python `attach` configuration'),
						host = host,
						options = {
							source_filetype = 'python',
							},
						})
				else
					callback({
						type = 'executable',
						command = '~/.virtualenvs/debugpy/bin/python',
						args = { '-m', 'debugpy.adapter' },
						options = {
							source_filetype = 'python',
							},
						})
				end
			end

			dap.configurations.python = {{
				-- The first three options are required by nvim-dap
				type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
				request = 'launch';
				name = "Launch file";

				-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

				program = "${file}"; -- This configuration will launch the current file if used.
				pythonPath = function()
					-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
					-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
					-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
					local cwd = vim.fn.getcwd()
					local venv_path = vim.fn.getenv('VIRTUAL_ENV')
					print(venv_path)
					print(cwd)
					if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
						return cwd .. '/venv/bin/python'
					elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
						return cwd .. '/.venv/bin/python'
					else
						return '/usr/bin/python'
					end
				end;
			},}
		end
	}
}
