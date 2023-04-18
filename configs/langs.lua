local M = {}

local function enable(name, when)
  return (when and name or nil)
end
local function enable_lsp(name, when)
  return (when and name or "marksman")
end
local function enable_src(b, name, when)
  return (when and name or b.completion.spell)
end

-- called in overrides.lua, plugins.lua, NEEDED null-ls

-- Don't forget to run :MasonInstallAll when changing one of the value
local rust = true
local typescript = false
local lua = true
local c = false
local cpp = false
local html = false
local css = false
local javascript = false

if typescript then
  html = true
  css = true
  javascript = true
end

M.parser = function()
  return {
    "vim",
    enable("lua", lua),
    enable("rust", rust),
    enable("html", html),
    enable("css", css),
    enable("javascript", javascript),
    enable("typescript", typescript),
    enable("tsx", typescript),
    enable("c", c),
    "markdown",
    "markdown_inline",
  }
end

M.lsp = function()
  return {
    -- We need at least one LSP and markdown is useful
    "marksman",
    enable_lsp("lua-language-server", lua),
    enable_lsp("stylua", lua),
    enable_lsp("css-lsp", css),
    enable_lsp("html-lsp", html),
    enable_lsp("typescript-language-server", typescript),
    enable_lsp("deno", (typescript or javascript)),
    enable_lsp("prettier", (typescript or javascript or rust or html or css)),
    enable_lsp("clangd", (c or cpp)),
    enable_lsp("clangd-format", (c or cpp)),
  }
end

M.sources = function(b)
  local function enable_ft(name, when)
    return (when and name or "")
  end
  local default_sources = {
    b.completion.spell,

    -- webdev stuff
    enable_src(b, b.formatting.deno_fmt, (typescript or javascript)),
    enable_src(
      b,
      b.formatting.prettier.with {
        filetypes = {
          "markdown",
          enable_ft("typescript", typescript),
          enable_ft("javascript", javascript),
          enable_ft("rust", rust),
          enable_ft("html", html),
          enable_ft("css", css),
        },
      },
      (typescript or javascript or rust or html or css)
    ),
    enable_src(b, b.formatting.stylua, lua),
    enable_src(b, b.formatting.clang_format, (c or cpp)),
  }
  return default_sources
end

M.plugin = function()
  local default_plugins = {
    enable({
      "simrat39/rust-tools.nvim",
      dependencies = {
        "neovim/nvim-lspconfig",
      },
      config = function()
        local opts = {
          -- all the opts to send to nvim-lspconfig
          -- these override the defaults set by rust-tools.nvim
          -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
          server = {
            -- standalone file support
            -- setting it to false may improve startup time
            standalone = true,
            on_attach = require("plugins.configs.lspconfig").on_attach,
            capabilities = require("plugins.configs.lspconfig").capabilities,
            settings = {
              -- to enable rust-analyzer settings visit:
              -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
              ["rust-analyzer"] = {
                -- enable clippy on save
                check = {
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
    }, rust),
  }
  return default_plugins
end

return M
