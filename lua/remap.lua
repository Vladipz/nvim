vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")


-- Keep the current line in the center of the screen when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Same as for scrolling but for going over search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- Keep the register contents when pasting over highlighted text
-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Space + p - paste without replacing text in register" })

-- Delete text without it moving into the register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], { desc = "Space + d - delete without replacing text in register" })


-- Remaps for navigating / deleting buffers
vim.keymap.set("n", "<leader>bd", vim.cmd.bd, { desc = "[B]uffer [D]elete" })
vim.keymap.set("n", "<leader>ba", "<CMD>%bd<CR>", { desc = "[B]uffer delete [A]ll" })
vim.keymap.set("n", "<leader>bc", "<CMD>%bd|e#|bd#<CR>", { desc = "[B]uffer delete except [C]urrent" })

vim.keymap.set("n", "<leader>rs", "<CMD>LspRestart<CR>", { desc = "[R]e[S]tart LSP" })


-- Splits 
vim.keymap.set("n", "<leader>sv", vim.cmd.vsp, { desc = "[S]plit [V]ertical" })
vim.keymap.set("n", "<leader>sh", vim.cmd.sp, { desc = "[S]plit [H]orizontal" })
vim.keymap.set("n", "<leader>ss", "<C-w>R", { desc = "[S]plit [S]wap" })
vim.keymap.set("n", "<leader>sc", "<C-w>c", { desc = "[S]plit [C]lose" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Ctrl + j in Normal Mode - go to bottom split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Ctrl + k in Normal Mode - go to top split" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Ctrl + h in Normal Mode - go to left split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Ctrl + l in Normal Mode - go to right split" })
-- Resizing splits
vim.keymap.set("n", "<C-Left>", "<CMD>vertical resize -2<CR>", { desc = "Ctrl + LeftArrow - make current split narrower" })
vim.keymap.set("n", "<C-Right>", "<CMD>vertical resize +2<CR>", { desc = "Ctrl + RightArrow - make current split wider" })
vim.keymap.set("n", "<C-Up>", "<CMD>resize +2<CR>", { desc = "Ctrl + UpArrow - make current split taller" })
vim.keymap.set("n", "<C-Down>", "<CMD>resize -2<CR>", { desc = "Ctrl + DownArrow - make current split shorter" })
