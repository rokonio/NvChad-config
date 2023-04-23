local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins
local sources = require("custom.configs.langs").sources(b)
local U = require "custom.configs.utils"
local utils = require "core.utils"

null_ls.setup {
  debug = true,
  -- Format with LSP if possible
  on_attach = function(client, bufnr)
    -- client.server_capabilities.documentFormattingProvider = true
    -- client.server_capabilities.documentRangeFormattingProvider = true

    U.fmt_on_save(client, bufnr)
    utils.load_mappings("lspconfig", { buffer = bufnr })
  end,
  sources = sources,
}
