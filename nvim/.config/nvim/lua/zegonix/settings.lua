-- enable line numbers and make them relative
vim.o.number = true
vim.o.relativenumber = true

-- sync clipboards of nvim and os
vim.o.clipboard = 'unnamedplus'

-- disable line wrap..
vim.o.wrap = false
vim.o.linebreak = true
vim.o.breakindent = true

-- enable mouse mode (default = '')
vim.o.mouse = 'a'

-- copies the indetation of the current line
vim.o.autoindent = true
vim.o.smartindent = true

-- search settings
vim.o.hlsearch = true -- enable highlighting of hits with current serch expression
vim.o.incsearch = true -- enable incremental search
vim.o.ignorecase = true -- search ignore case

-- set tab to 4 spaces and convert tabs to spaces
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- make cursor shy of window border by n lines/characters
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- view settings
vim.o.cursorline = true -- highlight current line
vim.o.termguicolors = true -- enable true colors (rgb)
vim.o.showmode = true -- show current mode (normal, insert, visual)
vim.o.pumheight = 8 -- pop up menu height
vim.o.signcolumn = "yes"
vim.o.updatetime = 250

-- history settings
vim.o.undofile = false


vim.o.completeopt = 'menuone,noselect'

vim.opt.isfname:append("@-@")

