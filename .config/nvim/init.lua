-- ~/.config/nvim/init.lua

vim.g.mapleader = " "

-- ===== lazy.nvim bootstrap =====
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "NvChad/nvim-colorizer.lua", opts = {} },
})

-- ===== Sensible defaults =====
local o = vim.opt

-- Include Vim's spell files (e.g. from vim-spell-de pacman package)
vim.opt.rtp:append("/usr/share/vim/vimfiles")

-- Truecolor
o.termguicolors = true

-- Line numbers
o.number         = true   -- absolute line number on the current line
o.relativenumber = true   -- relative numbers on the other lines

-- Indentation
o.expandtab  = true  -- tabs -> spaces
o.shiftwidth = 2     -- indentation size
o.tabstop    = 2     -- how many spaces a <Tab> shows as

-- UI
o.cursorline  = true   -- highlight current line
o.wrap        = true   -- soft wrapping
o.scrolloff   = 4      -- keep context lines above/below cursor
o.signcolumn  = "yes"  -- always show sign column
o.splitright  = true   -- vsplit opens right
o.splitbelow  = true   -- split opens below

-- Search
o.ignorecase = true
o.smartcase  = true
o.hlsearch   = false

-- Misc
o.mouse      = "a"             -- enable mouse
o.clipboard  = "unnamedplus"   -- use system clipboard
o.undofile   = true            -- persistent undo across sessions
o.updatetime = 250             -- faster CursorHold

-- ===== Transparency =====
-- Assumes your terminal emulator is set to be transparent
local function set_transparent_bg()
  vim.api.nvim_set_hl(0, "Normal",      { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "SignColumn",  { bg = "none" })
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = set_transparent_bg })
set_transparent_bg()

-- ===== Spellcheck =====
-- Enable for prose filetypes automatically
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit", "tex" },
  callback = function()
    vim.opt_local.spell     = true
    vim.opt_local.spelllang = "de,en_us"
  end,
})

-- Single custom spellfile so zg always adds to one place regardless of language
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/custom.utf-8.add"

-- Remapped for German keyboard (avoids AltGr combos for [ ] and Shift+0 for =)
vim.keymap.set("n", "<leader>st", function()
  vim.opt_local.spell = not vim.opt_local.spell:get()
end, { desc = "Toggle spellcheck" })

vim.keymap.set("n", "<leader>sn", "]s", { remap = true, desc = "Next misspelling" })
vim.keymap.set("n", "<leader>sp", "[s", { remap = true, desc = "Prev misspelling" })
vim.keymap.set("n", "<leader>ss", "z=", { remap = true, desc = "Spell suggestions" })
vim.keymap.set("n", "<leader>sa", "zg", { remap = true, desc = "Add word to dictionary" })
vim.keymap.set("n", "<leader>sw", "zw", { remap = true, desc = "Mark word as wrong" })
