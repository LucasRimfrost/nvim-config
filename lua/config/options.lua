local o = vim.opt
local g = vim.g

-- Basic Editor UI Configuration --
o.nu = true
o.relativenumber = true
o.cursorline = false
o.cmdheight = 0
o.signcolumn = "yes"
o.colorcolumn = "100"
o.scrolloff = 6
o.showmode = false
o.splitright = true
o.splitbelow = true
vim.o.winborder = "rounded"
-- o.guicursor = ""

-- File Handling & Backups --
o.swapfile = false
o.backup = false
o.undofile = true
o.updatetime = 250

-- Indentation & Spacing --
o.expandtab = true
o.smartindent = true
o.autoindent = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4

-- Search & Matching --
o.ignorecase = true
o.smartcase = true
o.hlsearch = false
o.incsearch = true

-- Editor Behavior --
o.mouse = "a"
o.wrap = false
o.backspace = "indent,eol,start"
o.conceallevel = 0
o.termguicolors = true

vim.env.TERM = "alacritty"

-- Special Characters --
o.isfname:append("@-@")
o.iskeyword:append("-")

o.list = true
o.listchars:append({
    space = "·",
    trail = "·",
    tab = "··",
})

-- Disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
