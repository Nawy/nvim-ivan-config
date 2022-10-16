-- basic lua configuration
o = vim.o
bo = vim.bo
wo = vim.wo

-- basic setups --
o.termguicolors = true
o.syntax = 'on'
o.errorbells = false
o.smartcase = true
o.showmode = false
o.updatetime = 300
o.signcolumn = 'yes'
o.backup = false
o.writebackup = false
o.backup = false
o.undodir = vim.fn.stdpath('config') .. '/undodir'
o.undofile = true
o.incsearch = true
o.hidden = true
o.completeopt='menuone,noinsert,noselect'
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.linespace = 8 
bo.swapfile = false
bo.autoindent = true
bo.smartindent = true
o.cursorline = true
wo.number = true
wo.relativenumber = true
wo.signcolumn = 'yes'
wo.colorcolumn = '79'
