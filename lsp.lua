-- Connect Mason with lspconfig
require("mason-lspconfig").setup({
  -- Automatically install these servers
  ensure_installed = {
    "lua_ls",      -- Lua
    "pyright",     -- Python
    "tsserver",    -- TypeScript/JavaScript
    "rust_analyzer", -- Rust
    "gopls",       -- Go
    "clangd",      -- C/C++
  },
  automatic_installation = true,

})

-- Key mappings
vim.keymap.set('n', '<leader>d', vim.lsp.buf.declaration, { desc = "Go to declaration" } )
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc = "Hover" })
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "Signature help" } )
vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, { desc = "Get references" } )
vim.keymap.set('n', '<leader>s', vim.lsp.buf.rename, { desc = "Symbol rename" } )
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, { desc = "Format buffer" } )
-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation" } )
-- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
