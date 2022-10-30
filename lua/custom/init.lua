local function load_lua_snippets_written_in_lua()
  local snippets = vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)
  for _, value in ipairs(snippets) do
    vim.cmd('luafile ' .. value)
  end
end

load_lua_snippets_written_in_lua()
