vim.cmd "setlocal colorcolumn=89"

vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true

vim.cmd [[ autocmd FileType python setlocal textwidth=80 wrap linebreak ]]
