-- Description: Keymaps configurations

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Escaping highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Hide search highlights' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Split window navigation
vim.keymap.set('n', '<leader>h', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>l', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>j', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>k', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- pv to Open file explore in the current buffer
vim.keymap.set('n', '<leader>pv', ':Explore<CR>', { desc = 'Open file explorer' })

-- > and < to shift blocks of text to the right and left, and keep the block selected
vim.keymap.set('v', '>', '>gv', { desc = 'Shift text to the right' })
vim.keymap.set('v', '<', '<gv', { desc = 'Shift text to the left' })

-- J / K on visual mode to move selected lines up and down
vim.keymap.set('x', 'J', ":move '>+1<CR>gv-gv", { desc = 'Move selected lines down' })
vim.keymap.set('x', 'K', ":move '<-2<CR>gv-gv", { desc = 'Move selected lines up' })
