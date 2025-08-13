require("nvim-tree").setup({
  filters = {
    dotfiles = false,
  },
    actions = {
        open_file = {
            window_picker = {
                enable = false
            }
        }
    }
}
)
vim.keymap.set('n', '<leader>n', '<cmd>NvimTreeToggle<CR>', { desc = "Toggle file explorer" })
vim.keymap.set('n', '<leader>nf', '<cmd>NvimTreeFocus<CR>', { desc = "Focus file explorer" })
