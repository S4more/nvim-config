local M = {}

M.telescope = {
  n = {
    ["<leader>tf"] = {"<cmd> Telescope find_functions <CR>", "Telescope find function"},
    ["<leader>fg"] = {"<cmd> Telescope live_grep initial_mode=insert<CR>", "Telescope find function"},
    ["<leader>tt"] = {"<cmd> Telescope lsp_type_definitions initial_mode=insert<CR>", "Telescope find function"},
  }
}

return M
