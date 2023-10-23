local plugins = {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "html",
                "javascript",
                "json",
                "lua",
                "python",
                "query",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "vue",
                "xml",
                "yaml"
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "jose-elias-alvarez/null-ls.nvim",
            config = function()
                require "custom.configs.null-ls"
            end,
        },
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "clangd",
                "css-lsp",
                "html-lsp",
                "lua-language-server",
                "python-lsp-server",
                "typescript-language-server",
                "vue-language-server"
            },
        },
    },
    {
        "stevearc/aerial.nvim",
        cmd = { "AerialToggle", "AerialOpen", "AerialPrev", "AerialNext" },
        init = function ()
            vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
            vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>')
            vim.keymap.set('n', '}', '<cmd>AerialNext<CR>')
        end,
        opts = function()
            return require "custom.configs.aerial"
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
    },
    {
        "mfussenegger/nvim-dap",
        config = function ()
            require "custom.configs.dap"
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
