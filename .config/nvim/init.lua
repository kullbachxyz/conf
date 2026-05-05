-- Leader keys.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core look and feel.
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd.colorscheme("industry")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = "unnamedplus"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

local undodir = vim.fn.stdpath("config") .. "/.nvim-state/undo"
vim.fn.mkdir(undodir, "p")
vim.opt.undodir = undodir

-- A few useful mappings, nothing fancy.
vim.keymap.set("n", "<leader><esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right window" })

-- Small quality-of-life autocmds.
local group = vim.api.nvim_create_augroup("MinimalConfig", { clear = true })

-- Briefly highlight yanked text.
vim.api.nvim_create_autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Return to the last cursor position when reopening a file.
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
