vim.g.mapleader = " "
vim.opt.swapfile = false
vim.opt.clipboard = "unnamed"
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
--vim.cmd("set laststatus=0")
vim.opt.nu = true
vim.opt.relativenumber = true

--shadafile
vim.opt.shadafile = "NONE"
vim.opt.showmode = false
vim.o.cmdheight=0

vim.opt.shellslash = false

vim.opt.hlsearch = false
local powershell_options = {
  shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
  shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
  shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
  shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
  shellquote = "",
  shellxquote = "",
}

for option, value in pairs(powershell_options) do
  vim.opt[option] = value
end
