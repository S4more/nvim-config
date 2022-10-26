local ts_locals = require "nvim-treesitter.locals"
local conf = require("telescope.config").values

local function has_value (tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

local expected_results = {
  "function",
}

local function prepare_match(entry, _)
  local entries = {}

  if entry.node then
    if has_value(expected_results, entry.kind) then
      entries[#entries+1] = entry
    end
  else
    for name, item in pairs(entry) do
      vim.list_extend(entries, prepare_match(item, name))
    end
  end

  return entries
end

local find_functions = function(opts)
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local make_entry = require("telescope.make_entry")
  local results = {}
  opts = opts or {}

  for _, definition in ipairs(ts_locals.get_definitions(opts.bufnr)) do
    local entries = prepare_match(ts_locals.get_local_nodes(definition))
    for _, entry in ipairs(entries) do
      entry.kind = vim.F.if_nil(entry.kind, "")
      results[#results+1] = entry
    end
  end

  pickers.new(opts, {
    prompt_title = "Find function",

    finder = finders.new_table {
      results = results,
      entry_maker = opts.entry_maker or make_entry.gen_from_treesitter(opts)
    },
    previewer = conf.qflist_previewer(opts),
    push_cursor_on_edit = true,
    push_tagstack_on_edit = true,

  }):find()
end

local present, telescope = pcall(require, "telescope")
if present then
  return telescope.register_extension({
    exports = { find_functions = find_functions }
  })
else
  error "Cannot find telescope!"
end

