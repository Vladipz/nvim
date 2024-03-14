



vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Ctrl + j in Normal Mode - go to bottom split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Ctrl + k in Normal Mode - go to top split" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Ctrl + h in Normal Mode - go to left split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Ctrl + l in Normal Mode - go to right split" })




local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)




require("nvim-options")
require("lazy").setup("plugins")


