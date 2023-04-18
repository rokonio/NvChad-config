---@type ChadrcConfig
--
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "chadracula",
  theme_toggle = { "chadracula", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,
  cmp = {
    lspkind_text = false,
    selected_item_bg = "simple", -- colored / simple
    style = "atom", -- default/flat_light/flat_dark/atom/atom_colored
  },
  tabufline = {
    overriden_modules = function()
      -- local modules = require "nvchad_ui.tabufline.modules"

      return {
        buttons = function()
          return ""
        end,
        -- or buttons = "" , this will hide the buttons
      }
    end,
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
