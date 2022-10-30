local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "tsserver", "rust_analyzer", "omnisharp", "jsonls"}

local defaultConfig = {
    on_attach = on_attach,
    capabilities = capabilities,
}

for _, lsp in ipairs(servers) do

  if lsp == "omnisharp" then
    defaultConfig["cmd"] = { "dotnet", "/home/samore/.config/nvim/lua/custom/plugins/omnisharp/OmniSharp.dll" }
  end

  lspconfig[lsp].setup(defaultConfig)

end
