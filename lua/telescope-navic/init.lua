local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local default = require("telescope-navic.default")
local navic = require("telescope-navic.navic")
local utils = require("telescope-navic.utils")

local config = default.config

function M.navic_picker(opts)
  opts = opts or {}
  local bufnr, filename = utils.get_buffer()
  local symbol_paths = navic.get_symbol_paths(bufnr, config)

  if #symbol_paths == 0 then
    vim.notify("No symbols found in the current buffer.")
    return
  end

  pickers
    .new(opts, {
      prompt_title = "Navic Symbol Paths",
      finder = finders.new_table({
        results = symbol_paths,
        entry_maker = function(entry)
          return {
            value = entry,
            path = filename,
            display = function()
              return entry.value, entry.highlights
            end,
            ordinal = entry.value,
            lnum = entry.lnum,
            col = entry.col,
            sorter_num = entry.lnum * 1024 + entry.col, -- sort by line, then by col, if #col <= 1024
          }
        end,
      }),
      sorter = conf.prefilter_sorter({
        tag = "sorter_num",
        sorter = conf.generic_sorter(opts),
      }),
      previewer = conf.grep_previewer(opts),
    })
    :find()
end

function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts)
end

return M
