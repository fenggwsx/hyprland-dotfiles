---@type ChadrcConfig 
local M = {}
M.ui = {
    theme = 'onedark',
    hl_override = {
        CursorLine = {
            bg = "#282a2e"
        }
    },
    statusline = {
        theme = "vscode_colored",
        separator_style = "default",
    },
    tabufline = {
        overriden_modules = function(modules)
            modules[4] = (function()
                return ""
            end)()
        end,
    },
}
M.plugins = "custom.plugins"
return M
