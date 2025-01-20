vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.g.netrw_banner = 0
vim.g.netrw_preview = 1

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.colorcolumn = "+1"

-- Decrease update time
vim.opt.updatetime = 250

-- Configure how new splits should be opened
-- vim.opt.splitright = true
-- vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { trail = "·", nbsp = "␣", tab = "» " }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8

-- Disable line wrapping
vim.opt.wrap = false

vim.o.tabstop = 4
vim.o.softtabstop = 0
vim.o.shiftwidth = 4

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Execute lua keymaps
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute current lua file" })
vim.keymap.set("n", "<leader>x", ":.lua<CR>", { desc = "Execute current lua line" })
vim.keymap.set("v", "<leader>x", ":lua<CR>", { desc = "Execute selected lua" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Explorer toggle - checks if in netrw
-- vim.keymap.set("n", "<leader>et", "<CMD>Explore .<CR>")
vim.keymap.set("n", "<leader>et", function()
	if vim.bo.filetype == "netrw" then
		vim.cmd("Rex")
	else
		vim.cmd("Explore .")
	end
end)

vim.keymap.set("n", "<leader>ef", "<CMD>Explore<CR>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Disable providers as I only use lua plugins
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Listen to a godot host file
-- This makes the nvim jump to correct line and file when file chosen in godot editor
local projectfile = vim.fn.getcwd() .. "/project.godot"
if vim.fn.filereadable(projectfile) == 1 then
	vim.fn.serverstart("./godothost")
end

-- Install Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
