vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = false

vim.opt.title = true
vim.opt.background = "light"
vim.opt.hlsearch = false
vim.cmd("colorscheme vim")

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.g.mapleader = "  "
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':wq<CR>')
vim.keymap.set('n', '<leader>s', ':so<CR>') -- Source current file
vim.keymap.set('n', '<leader>e', '<cmd>!chmod +x %<CR>') -- Make current file executable
vim.keymap.set('n', '<leader>r', '<cmd>!%:p<CR>') -- Run current file

vim.opt.mouse = "a" -- Enable mouse usage

-- Spellcheck
vim.opt.spell = true
vim.opt.spelllang = { "en", "de" }
vim.api.nvim_set_hl(0, "SpellBad", { cterm = { underline = true }, ctermfg = 1 })

vim.api.nvim_set_hl(0, "Comment", { ctermfg = 7 })

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.scrolloff = 8

vim.opt.undofile = true
vim.opt.swapfile = false

