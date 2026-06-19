vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = false

vim.opt.wrap = true
vim.opt.linebreak = true

vim.g.mapleader = "  "
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':wq<CR>')
vim.keymap.set('n', '<leader>s', ':so<CR>')

vim.opt.mouse = "a" -- Enable mouse usage
vim.opt.spell = true
vim.opt.spelllang = { "en", "de" }

vim.api.nvim_set_hl(0, "Comment", { ctermfg = 7 })

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.scrolloff = 8

vim.opt.undofile = true
vim.opt.swapfile = false
