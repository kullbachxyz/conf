-- ~/.config/nvim/init.lua

vim.g.mapleader = " "

-- Auto-install vim-plug if missing
local plug_path = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'
if vim.fn.empty(vim.fn.glob(plug_path)) > 0 then
  vim.fn.system({'curl', '-fLo', plug_path, '--create-dirs',
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'})
  vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

-- vim-plug block
vim.cmd [[
  call plug#begin('~/.local/share/nvim/plugged')
  Plug 'norcalli/nvim-colorizer.lua'
  call plug#end()
]]

-- Truecolor for nice colors & plugins
vim.opt.termguicolors = true

-- ===== Sensible defaults =====
local o = vim.opt

-- Line numbers
o.number = true            -- absolute line number on the current line
o.relativenumber = true    -- relative numbers on the other lines

-- Indentation
o.expandtab = true         -- tabs -> spaces
o.shiftwidth = 2           -- indentation size
o.tabstop = 2              -- how many spaces a <Tab> shows as
o.smartindent = true

-- UI tweaks
o.cursorline = true        -- highlight current line
o.wrap = true              -- soft wrapping
o.scrolloff = 4            -- keep some context lines above/below cursor
o.signcolumn = "yes"       -- always show sign column

-- Search
o.ignorecase = true
o.smartcase = true
o.hlsearch = false

-- Misc
o.mouse = "a"              -- enable mouse
o.clipboard = "unnamedplus" -- use system clipboard

-- ===== Transparency =====
-- This assumes your terminal emulator itself is set to be transparent
vim.cmd [[
  augroup TransparentBackground
    autocmd!
    " main window
    autocmd ColorScheme * highlight Normal       ctermbg=none guibg=none
    " floating windows
    autocmd ColorScheme * highlight NormalFloat  ctermbg=none guibg=none
    " sign column (git signs, diagnostics, etc.)
    autocmd ColorScheme * highlight SignColumn   ctermbg=none guibg=none
  augroup END
]]

-- apply once on startup too (in case no :colorscheme is run)
vim.cmd [[
  highlight Normal       ctermbg=none guibg=none
  highlight NormalFloat  ctermbg=none guibg=none
  highlight SignColumn   ctermbg=none guibg=none
]]

-- ===== Spellcheck =====
-- Enable for prose filetypes automatically
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit", "tex" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "de,en_us"
  end,
})

-- Single custom spellfile so zg always adds to one place regardless of language
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/custom.utf-8.add"

-- Remapped for German keyboard (avoids AltGr combos for [ ] and Shift+0 for =)
vim.keymap.set("n", "<leader>st", function()
  vim.opt_local.spell = not vim.opt_local.spell:get()
end, { desc = "Toggle spellcheck" })

vim.keymap.set("n", "<leader>sn", "]s",  { remap = true, desc = "Next misspelling" })
vim.keymap.set("n", "<leader>sp", "[s",  { remap = true, desc = "Prev misspelling" })
vim.keymap.set("n", "<leader>ss", "z=",  { remap = true, desc = "Spell suggestions" })
vim.keymap.set("n", "<leader>sa", "zg",  { remap = true, desc = "Add word to dictionary" })
vim.keymap.set("n", "<leader>sw", "zw",  { remap = true, desc = "Mark word as wrong" })

-- ===== Colorizer =====
pcall(function() require("colorizer").setup() end)

