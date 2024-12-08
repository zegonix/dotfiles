-- set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- disable the spacebar key's default behaviour in normal and visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- command options
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set({ 'n' }, '<C-s>', '<cmd> w <CR>', opts)

-- quit file
vim.keymap.set('n', '<C-x>', '<cmd> q <CR>', opts)


-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Buffers
--vim.keymap.set('n', '<C-Tab>', ':bnext<CR>', opts)
--vim.keymap.set('n', '<C-S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>w', ':bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>n', '<cmd> enew <CR>', opts) -- new buffer

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- Navigate between splits
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Tabs
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tw', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<C-Tab>', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set('n', '<C-S-Tab>', ':tabp<CR>', opts) --  go to previous tab
