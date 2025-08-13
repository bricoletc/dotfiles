require("nvim-tree").setup()
vim.keymap.set('n', '<leader>n', '<cmd>NvimTreeToggle<CR>', { desc = "Toggle file explorer" })
vim.keymap.set('n', '<leader>nf', '<cmd>NvimTreeFocus<CR>', { desc = "Focus file explorer" })
