local default_on_attach = require("plugins.configs.lspconfig").on_attach
local lsp_config = require "lspconfig"
-- local capabilities = require("plugins.configs.lspconfig").capabilities
local utils = require "core.utils"
local on_attach = function(client, bufnr)
  default_on_attach(client, bufnr)
  utils.load_mappings("lspconfig", { buffer = bufnr })
end
local capabilities = require("plugins.configs.lspconfig").capabilities

require("mason-lspconfig").setup_handlers {
  function(server_name)
    lsp_config[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,
  ["lua_ls"] = function()
    lsp_config.lua_ls.setup {
      on_attach = on_attach,
      capabilities = capabilities,

      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
              [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      },
    }
  end,
}
-- if you just want default config for the servers then put them in a table
-- local servers = { "html", "cssls", "tsserver", "clangd" }

-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }
-- end

--
-- lspconfig.pyright.setup { blabla}
