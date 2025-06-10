-- enable line numbers and make them relative
vim.wo.number = true
vim.o.relativenumber = true

-- sync clipboards of nvim and os
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

-- disable line wrap..
vim.o.wrap = false
vim.o.linebreak = true
vim.o.breakindent = true

-- enable mouse mode (default = '')
vim.o.mouse = "a"

-- copies the indetation of the current line
vim.o.autoindent = true
vim.o.smartindent = true

-- search settings
vim.o.hlsearch = true                               -- enable highlighting of hits with current serch expression
vim.o.incsearch = true                              -- enable incremental search
vim.o.ignorecase = true                             -- search ignore case
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- clear search highlight on `ESC`

-- set tab to 4 spaces and convert tabs to spaces
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- make cursor shy of window border by n lines/characters
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- view settings
vim.o.cursorline = true    -- highlight current line
vim.o.termguicolors = true -- enable true colors (rgb)
vim.o.showmode = false     -- show current mode (normal, insert, visual)
vim.o.pumheight = 10       -- pop up menu height
vim.o.cmdheight = 1
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 1500
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.conceallevel = 0
vim.o.fillchars = "vert:│,horiz:─"

-- history settings
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- stuff
vim.opt.undofile = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.whichwrap = "bs<>[]hl" -- which "horizontal" keys are allowed to travel to prev/next line
vim.o.backspace = "indent,eol,start"
vim.o.fileencoding = "utf-8"

vim.o.completeopt = "menuone,noselect"

vim.opt.isfname:append("@-@")

vim.opt.shortmess:append("c")                         -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append("-")                         -- hyphenated words recognized by searches
vim.opt.formatoptions:remove({ "c", "r", "o" })       -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use
