local state = {
  rust = true,
  typescript = true,
  lua = true,
  c = false,
  cpp = false,
  html = true,
  css = true,
  javascript = true,
}

if state.typescript then
  state.css = true
  state.html = true
  state.javascript = true
end

-- Remove duplicate items from a list
local uniq = function(l)
  local hash = {}
  local res = {}

  for _, v in ipairs(l) do
    if not hash[v] then
      res[#res + 1] = v -- you could print here instead of saving to result table if you wanted
      hash[v] = true
    end
  end
  return res
end

local M = {}
M.items = {
  {
    name = "rust",
    treesitter_parsers = { "rust" },
    mason_lspconfig_servers = {},
    mason_other_servers = {},
    null_ls_sources = function(null_ls)
      return {
        null_ls.builtins.formatting.rustfmt,
      }
    end,
    -- use_lsp_fmt = true,
    additional_plugins = {
      {
        "simrat39/rust-tools.nvim",
        dependencies = {
          "neovim/nvim-lspconfig",
        },
        ft = "rust",
        config = function()
          local opts = {
            -- all the opts to send to nvim-lspconfig
            -- these override the defaults set by rust-tools.nvim
            -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
            server = {
              on_attach = require("plugins.configs.lspconfig").on_attach,
              capabilities = require("plugins.configs.lspconfig").capabilities,
              settings = {
                -- to enable rust-analyzer settings visit:
                -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                ["rust-analyzer"] = {
                  -- enable clippy on save
                  checkOnSave = {
                    command = "clippy",
                  },
                  imports = {
                    granularity = {
                      group = "module",
                      enforce = true,
                    },
                  },
                },
              }, -- rust-analyer options
            },
          }
          require("rust-tools").setup(opts)
        end,
      },
    },
  },
  {
    name = "html",
    treesitter_parsers = { "html" },
    mason_lspconfig_servers = { "html" },
    mason_other_servers = { "prettier" },
    null_ls_sources = function(null_ls)
      return {
        null_ls.builtins.formatting.prettier,
      }
    end,
    additional_plugins = {},
  },
  {
    name = "lua",
    treesitter_parsers = { "lua" },
    mason_lspconfig_servers = { "lua_ls" },
    mason_other_servers = { "stylua" },
    null_ls_sources = function(null_ls)
      return {
        null_ls.builtins.formatting.stylua,
      }
    end,
    additional_plugins = {},
  },
  {
    name = "css",
    treesitter_parsers = { "css" },
    mason_lspconfig_servers = { "cssls" },
    mason_other_servers = {},
    null_ls_sources = function(null_ls)
      return {
        null_ls.builtins.formatting.prettier,
      }
    end,
    additional_plugins = {},
  },
  {
    name = "javascript",
    treesitter_parsers = { "javascript" },
    mason_lspconfig_servers = { "denols" },
    mason_other_servers = {},
    null_ls_sources = function(null_ls)
      return {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.deno_fmt,
      }
    end,
    additional_plugins = {},
  },
  {
    name = "typescript",
    treesitter_parsers = { "typescript" },
    mason_lspconfig_servers = { "tsserver", "denols" },
    mason_other_servers = {},
    null_ls_sources = function(null_ls)
      return {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.deno_fmt,
      }
    end,
    additional_plugins = {},
  },
  {
    name = "c",
    treesitter_parsers = { "c" },
    mason_lspconfig_servers = { "clangd" },
    mason_other_servers = { "clang-format" },
    null_ls_sources = function(null_ls)
      return {
        null_ls.builtins.formatting.clang_format,
      }
    end,
    additional_plugins = {},
  },
  {
    name = "cpp",
    treesitter_parsers = { "cpp" },
    mason_lspconfig_servers = { "clangd" },
    mason_other_servers = { "clang-format" },
    null_ls_sources = function(null_ls)
      return {
        null_ls.builtins.formatting.clang_format,
      }
    end,
    additional_plugins = {},
  },
}

M.treesitter_parsers = function()
  local parsers = {}
  for _, l in ipairs(M.items) do
    if state[l.name] then
      vim.list_extend(parsers, l.treesitter_parsers)
    end
  end
  return uniq(parsers)
end
M.mason_lspconfig_servers = function()
  local servers = {}
  for _, l in ipairs(M.items) do
    if state[l.name] then
      vim.list_extend(servers, l.mason_lspconfig_servers)
    end
  end
  return uniq(servers)
end
M.mason_other_servers = function()
  local other_servers = {}
  for _, l in ipairs(M.items) do
    if state[l.name] then
      vim.list_extend(other_servers, l.mason_other_servers)
    end
  end
  return uniq(other_servers)
end
M.mason_all_servers = function()
  local mason_lspconfig_mapping = require("mason-lspconfig").get_mappings()
  local all_servers = M.mason_other_servers()
  for _, s in ipairs(M.mason_lspconfig_servers()) do
    if state[s.name] then
      table.insert(all_servers, mason_lspconfig_mapping.lspconfig_to_mason[s])
    end
  end
  return all_servers
end
M.null_ls_sources = function()
  local null_ls = require "null-ls"
  local sources = {}
  for _, l in ipairs(M.items) do
    if state[l.name] then
      vim.list_extend(sources, l.null_ls_sources(null_ls))
    end
  end
  sources = uniq(sources)
  return sources
end
M.additional_plugins = function()
  local plugins = {}
  for _, l in ipairs(M.items) do
    if state[l.name] then
      vim.list_extend(plugins, l.additional_plugins)
    end
  end
  return uniq(plugins)
end

return M
