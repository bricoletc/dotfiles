local builtin_ok, builtin = pcall(require, 'telescope.builtin')
if builtin_ok then
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Buffers" })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })
  -- LSP-related searches
  vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions, { desc = "Find definitions" })
  vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = "Find references" })
end
