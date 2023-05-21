---@type ChadrcConfig

local M = {}

M.ui = {
  theme = "chadracula",
  cmp = {
    lspkind_text = true,
    selected_item_bg = "simple",
    style = "atom",
  },
  tabufline = {
    overriden_modules = function()
      return {
        buttons = function()
          return ""
        end,
      }
    end,
  },
}

M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

return M
