local M = {}
local parsers = require("custom.configs.langs").parser()
local lsps = require("custom.configs.langs").lsp()

M.treesitter = {
  ensure_installed = parsers,
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = lsps,
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    root_folder_label = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
