local remove_whitespace_group = vim.api.nvim_create_augroup("remove_whitespace", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = "%s/\\s\\+$//e",
    group = remove_whitespace_group,
})
