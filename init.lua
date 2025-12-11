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
        -- Utility functions (dependency for many plugins)
        {"nvim-lua/plenary.nvim"}, 
        -- TSVs
        {"mechatroner/rainbow_csv"},
        -- Key binding helper
        {"folke/which-key.nvim"},
        -- Git Blame
        {
            "FabijanZulj/blame.nvim",
            config = function()
              require('blame').setup {}
            end,
        },
        -- File Explorer/Tree --
        {import = "plugins.explorer"},
        -- Syntax Highlighting --
        {import = "plugins.treesitter"},
        --- Fuzzy Finder --
        {import = "plugins.telescope"},
        -- LSP servers --
        {import = "plugins.lsp"},
        --- Code completion --
        {import = "plugins.completion"},

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

vim.keymap.set('n', '<Leader>m' ,'<cmd>:BlameToggle<cr>', {desc = 'Toggle Git Blaming'})
vim.keymap.set('n', '<leader>n',  '<cmd>NvimTreeToggle<CR>', { desc = "Toggle file explorer" })
vim.keymap.set('n', '<leader>nf', '<cmd>NvimTreeFocus<CR>',  { desc = "Focus file explorer" })

local builtin_ok, builtin = pcall(require, 'telescope.builtin')
if builtin_ok then
  vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = "Buffers" })
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })
end

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Get floating diagnostic" })
vim.keymap.set('n', '<leader>g', vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, { desc = "Get references" })
vim.keymap.set('n', '<leader>s', vim.lsp.buf.rename, { desc = "Symbol rename" })
vim.keymap.set('n', '<leader>l', function() vim.lsp.buf.format { async = true } end, { desc = "Format buffer" })
-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation" } )
-- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
