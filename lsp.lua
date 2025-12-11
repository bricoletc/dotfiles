return {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
    config = function()
        -- Connect Mason with lspconfig
        require("mason-lspconfig").setup({
            -- Automatically install these servers
            ensure_installed = {
                "lua_ls",    -- Lua
                "pyright",   -- Python
                "ruff",      -- Python, including formatting
                "rust_analyzer", -- Rust
                -- "gopls",       -- Go
                "clangd",    -- C/C++
            },
            automatic_installation = true,
            -- automatic_enable = false,
        })
    end
}
