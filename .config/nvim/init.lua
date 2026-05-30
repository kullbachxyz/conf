-- Ported from the NixOS Neovim config and adapted for the Arch home layout.

------------------------------------------------------------
-- Basics
------------------------------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.mouse = "a"
vim.opt.spell = true
vim.opt.spelllang = { "en", "de" }

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

------------------------------------------------------------
-- XDG-safe state/cache paths
------------------------------------------------------------

local state_dir = vim.fn.stdpath("state")
local cache_dir = vim.fn.stdpath("cache")
local undodir = vim.fn.stdpath("config") .. "/.nvim-state/undo"

vim.fn.mkdir(state_dir, "p")
vim.fn.mkdir(cache_dir, "p")
vim.fn.mkdir(undodir, "p")

vim.opt.undodir = undodir

------------------------------------------------------------
-- Minimal black colorscheme
------------------------------------------------------------

local group = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "#000000", fg = "#d0d0d0" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000", fg = "#b0b0b0" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#000000", fg = "#000000" })

    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#101010" })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "#000000", fg = "#404040" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#101010", fg = "#ffffff" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "#000000" })

    vim.api.nvim_set_hl(0, "StatusLine", { bg = "#111111", fg = "#d0d0d0" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#050505", fg = "#606060" })

    vim.api.nvim_set_hl(0, "Pmenu", { bg = "#111111", fg = "#d0d0d0" })
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#303030", fg = "#ffffff" })

    vim.api.nvim_set_hl(0, "Visual", { bg = "#303030" })
    vim.api.nvim_set_hl(0, "Search", { bg = "#404040", fg = "#ffffff" })
    vim.api.nvim_set_hl(0, "IncSearch", { bg = "#ffffff", fg = "#000000" })
  end,
})

vim.cmd.colorscheme("default")
vim.cmd("doautocmd ColorScheme")

------------------------------------------------------------
-- Keymaps
------------------------------------------------------------

local map = vim.keymap.set

map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<leader><esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })
map("n", "<leader>e", "<cmd>Ex<cr>", { desc = "Open netrw" })

map("n", "<C-h>", "<C-w>h", { desc = "Move left" })
map("n", "<C-j>", "<C-w>j", { desc = "Move down" })
map("n", "<C-k>", "<C-w>k", { desc = "Move up" })
map("n", "<C-l>", "<C-w>l", { desc = "Move right" })

------------------------------------------------------------
-- Bootstrap lazy.nvim
------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

------------------------------------------------------------
-- Plugins
------------------------------------------------------------

local find_command
if vim.fn.executable("fd") == 1 then
  find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" }
elseif vim.fn.executable("rg") == 1 then
  find_command = { "rg", "--files", "--hidden", "--glob", "!.git" }
else
  find_command = { "find", ".", "-type", "f" }
end

local telescope_defaults = {
  prompt_prefix = "> ",
  selection_caret = "  ",
  entry_prefix = "  ",
  sorting_strategy = "ascending",
  layout_config = {
    prompt_position = "top",
  },
}

if vim.fn.executable("rg") == 1 then
  telescope_defaults.vimgrep_arguments = {
    "rg",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
  }
end

require("lazy").setup({
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          globalstatus = true,
          icons_enabled = false,
          section_separators = "",
          component_separators = "",
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = telescope_defaults,
        pickers = {
          find_files = {
            find_command = find_command,
          },
        },
      })

      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      if vim.fn.executable("rg") == 1 then
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      end
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
    end,
  },

  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.pairs").setup()
      require("mini.comment").setup()
      require("mini.surround").setup()
    end,
  },
}, {
  lockfile = state_dir .. "/lazy-lock.json",
})

------------------------------------------------------------
-- Small quality-of-life autocommands
------------------------------------------------------------

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  callback = function()
    if vim.o.diff then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local last_line = vim.api.nvim_buf_line_count(0)
    if mark[1] < 1 or mark[1] > last_line then
      return
    end

    pcall(vim.api.nvim_win_set_cursor, 0, mark)
  end,
})
