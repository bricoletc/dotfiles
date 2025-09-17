-- Credit: https://dev.to/mochafreddo/configuring-neovim-with-initlua-a-comprehensive-guide-2a7i

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Basic settings
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.number = true -- Enable line numbers
-- vim.o.relativenumber = true -- Enable relative line numbers
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.tabstop = 4 -- Number of spaces a tab represents
vim.o.shiftwidth = 4 -- Number of spaces for each indentation
vim.o.autoindent = true -- Automatically indent new lines
vim.o.smartindent = true -- Automatically indent new lines
vim.o.wrap = true -- Disable line wrapping

vim.o.undofile = true -- Persistent undo trees

vim.o.ignorecase = true
vim.o.smartcase = true --if search contains uppercase, search becomes case-sensitive. To search lowercase only, use `pattern\C`.

vim.o.cursorline = true -- Highlight the current line
vim.o.termguicolors = true -- Enable 24-bit RGB colors

vim.keymap.set({'i'}, 'jj' ,'<esc>', {desc = 'Finger-quick exit from insert mode'})

vim.filetype.add({
  extension = {
        nf = 'groovy'
  },
})

-- vim.keymap.set({'n'}, '<Leader>b' ,'<cmd>:buffers<cr>', {desc = 'Open the buffers'})

vim.keymap.set({'n', 'x'}, 'gy', '"+y', {desc = 'Copy to clipboard'})
vim.keymap.set({'n', 'x'}, 'gp', '"+p', {desc = 'Paste clipboard content'})

vim.keymap.set({'n'}, '<C-q>', '<C-w>q', {desc = "Close window"})
vim.keymap.set({'n'}, '<C-j>', '<C-w>j', {desc = "Go to window down"})
vim.keymap.set({'n'}, '<C-k>', '<C-w>k', {desc = "Go to window up"})
vim.keymap.set({'n'}, '<C-l>', '<C-w>l', {desc = "Go to window right"})
vim.keymap.set({'n'}, '<C-h>', '<C-w>h', {desc = "Go to window left"})

vim.keymap.set({'n'}, '11', '1gt', {desc = "Go to tab 1"})
vim.keymap.set({'n'}, '22', '2gt', {desc = "Go to tab 2"})
vim.keymap.set({'n'}, '33', '2gt', {desc = "Go to tab 3"})

-- vim.keymap.set({'n'}, '<Leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', {desc = 'Substitute word under cursor'})

vim.keymap.set({'n'}, '<Leader>v', '<cmd>:edit $MYVIMRC<cr>', {desc = 'Fast access to config'})

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- Essential plugins
        "nvim-lua/plenary.nvim", -- Utility functions (dependency for many plugins)

        -- TSVs
        {
            "mechatroner/rainbow_csv",
        },
        -- Treesitter for syntax highlighting (load early)
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            priority = 100, -- Load early
        },
        -- Language Server Protocol
        {
            "mason-org/mason-lspconfig.nvim",
            opts = {},
            dependencies = {
                { "mason-org/mason.nvim", opts = {} },
                "neovim/nvim-lspconfig",
            },
        },
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
                "hrsh7th/cmp-buffer",   -- Buffer source
                "hrsh7th/cmp-path",     -- Path source
                -- "L3MON4D3/LuaSnip",     -- Snippet engine
                -- "saadparwaiz1/cmp_luasnip", -- Snippet source
            },
        },
        -- File explorer
        {
            "nvim-tree/nvim-tree.lua",
            dependencies = { "nvim-tree/nvim-web-devicons" },
        },

        -- Fuzzy finder
        {
            "nvim-telescope/telescope.nvim",
            dependencies = { "nvim-lua/plenary.nvim" }
        },

        -- Key binding helper
        {
            "folke/which-key.nvim",
        },

    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { 
        enabled = true,
        notify = false,
    },
})

require('user.treesitter')
require('user.lsp')
require('user.completion')
require('user.explorer')
require('user.telescope')
