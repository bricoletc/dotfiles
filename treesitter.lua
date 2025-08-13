require('nvim-treesitter.configs').setup {
  -- Install these parsers by default
  ensure_installed = { 
    "lua", "vim", "vimdoc", "python", "r", 
    "go", "html", "css", "json", "yaml", "toml", "markdown", "bash" 
  },
  auto_install = true, -- Automatically install missing parsers
  highlight = {
    enable = true,
    disable = { "tsv", "csv", "psv"},
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
    },
  },
}
