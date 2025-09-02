-- Connect Mason with lspconfig
require("mason-lspconfig").setup({
  -- Automatically install these servers
  ensure_installed = {
    "lua_ls",      -- Lua
    "pyright",     -- Python
    "rust_analyzer", -- Rust
    -- "gopls",       -- Go
    "clangd",      -- C/C++
  },
  automatic_installation = true,
  -- automatic_enable = false,
})


-- Key mappings
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Get floating diagnostic" } )
vim.keymap.set('n', '<leader>g', vim.lsp.buf.definition, { desc = "Go to definition"} )
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc = "Hover" })
vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, { desc = "Get references" } )
vim.keymap.set('n', '<leader>s', vim.lsp.buf.rename, { desc = "Symbol rename" } )
-- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, { desc = "Format buffer" } )
-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation" } )
-- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
