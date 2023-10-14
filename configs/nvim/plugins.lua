local plugins = {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {"c", "cpp", "python", "html", "css", "bash"},
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        opts = {
            enabled = function()
                return (vim.bo.ft ~= "markdown")
            end,
        },
    },
    {
        "rafamadriz/friendly-snippets", enabled = false
    },
}

return plugins
