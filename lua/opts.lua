-- Make line numbers default
vim.opt.number = true

-- Set relative numbers
vim.opt.rnu = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Show which line your cursor is on
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20

-- Show the 80 char limit and the 120 char limit
vim.opt.colorcolumn = '80,120'

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- Set the shell for commands
vim.opt.shell = '/bin/zsh'

-- Spell checking
vim.opt.spell = true
vim.opt.spelllang = 'en_us'
vim.opt.spelloptions = 'camel,noplainbuffer'
