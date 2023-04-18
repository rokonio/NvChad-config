---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-s>"] = { "<cmd> w <CR><cmd> lua vim.lsp.buf.format{ async = true } <CR>", "save file" },
    ["<leader>un"] = { "<cmd> set nu! <CR>", "toggle line number" },
    ["<leader>ur"] = { "<cmd> set rnu! <CR>", "toggle relative number" },
    ["<leader>ub"] = {
      function()
        if vim.o.showtabline == 0 then
          vim.o.showtabline = 2
        elseif vim.o.showtabline == 2 then
          vim.o.showtabline = 0
        end
      end,
      "toggle bufferline",
    },
    ["<leader>us"] = {
      function()
        if vim.o.laststatus == 0 then
          vim.o.laststatus = 3
        elseif vim.o.laststatus == 3 then
          vim.o.laststatus = 0
        end
      end,
      "toggle status line",
    },
  },
}

M.tabufline = {
  plugin = true,

  n = {
    ["<S-L>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflineNext()
      end,
      "goto next buffer",
    },

    ["<S-H>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflinePrev()
      end,
      "goto prev buffer",
    },
    ["<leader>q"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
        -- TODO finish here
        -- require("nvimtree").close_buffer
      end,
      "close buffer",
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "toggle file explorator" },

    -- focus
    ["<leader>o"] = { "<cmd> NvimTreeFocus <CR>", "focus file navigator" },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- theme switcher
    ["<leader>ut"] = { "<cmd> Telescope themes <CR>", "nvchad themes" },
  },
}

M.disabled = {
  n = {
    ["<C-c>"] = "",
    ["<C-n>"] = "",
    ["<leader>b"] = "",
    ["<tab>"] = "",
    ["<S-tab>"] = "",
    ["<leader>th"] = "",
  },
}
-- more keybinds!

return M
