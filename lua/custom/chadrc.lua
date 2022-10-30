-- First read our docs (completely) then check the example_config repo

local M = {}

M.ui = {
  theme = "onedark",
}

M.plugins = {
  ["neovim/nvim-lspconfig"] = {
      config = function()
        require "plugins.configs.lspconfig"
        require "custom.plugins.lspconfig"
      end,
  },
  ["notjedi/nvim-rooter.lua"] = {
    config = function()
      print("here")
      require 'nvim-rooter'.setup()
    end
  },
}

M.mappings = require "custom.mappings"

return M
