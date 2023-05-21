local additional_plugins = require("custom.configs.langs").additional_plugins
local treesitter_parsers = require("custom.configs.langs").treesitter_parsers
local mason_other_servers = require("custom.configs.langs").mason_other_servers
local mason_lspconfig_servers = require("custom.configs.langs").mason_lspconfig_servers

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
          {
            "williamboman/mason.nvim",
            opts = {
              ensure_installed = mason_other_servers(),
            },
          },
        },
        opts = {
          ensure_installed = mason_lspconfig_servers(),
        },
      },
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      local mr = require "mason-registry"
      local function ensure_installed()
        for _, tool in ipairs(mason_other_servers()) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = treesitter_parsers(),
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
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
    },
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "Pocco81/true-zen.nvim",
    cmd = { "TZAtaraxis", "TZMinimalist" },
  },
  {
    "ziontee113/color-picker.nvim",
    cmd = "PickColor",
    config = function()
      require "color-picker"
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      vim.opt.termguicolors = true
      -- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
      -- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
      -- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
      -- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
      -- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
      -- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

      vim.cmd [[highlight IndentBlanklineIndent1 guifg=#6e171e gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guifg=#765517 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent3 guifg=#3b5727 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent4 guifg=#1e4c52 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent5 guifg=#0c497a gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent6 guifg=#5a1b6d gui=nocombine]]

      require("indent_blankline").setup {
        show_currentdcontext = true,
        show_current_context_start = false,
        space_char_blankline = " ",
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
          "IndentBlanklineIndent3",
          "IndentBlanklineIndent4",
          "IndentBlanklineIndent5",
          "IndentBlanklineIndent6",
        },
      }
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = {
      "numToStr/Comment.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("nvim-treesitter.configs").setup {
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      }
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },
  {
    "Darazaki/indent-o-matic",
    lazy = false,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },
}

vim.list_extend(plugins, additional_plugins())

return plugins
