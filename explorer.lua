return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup {
            filters = {
                dotfiles = false,
            },
            actions = {
                open_file = {
                    window_picker = {
                        enable = false
                    }
                }
            },
        }
    end
}
