-- local on_attach = require("plugins.configs.lspconfig").on_attach
-- local capabilities = require("plugins.configs.lspconfig").capabilities
local utils = require "core.utils"

require("mason-lspconfig").setup_handlers {
  function(server_name)
    local on_attach = function(client, bufnr)
      utils.load_mappings("lspconfig", { buffer = bufnr })
    end
    local capabilities = require("plugins.configs.lspconfig").capabilities
    require("lspconfig")[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities,
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
