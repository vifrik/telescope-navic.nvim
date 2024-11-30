local has_navic, navic = pcall(require, "nvim-navic.lib")
if not has_navic then
  error("This extension requires nvim-navic (https://github.com/SmiteshP/nvim-navic)")
end

local utils = require("telescope-navic.utils")

local function traverse(node, current_path, symbol_entries, config)
  if not node or not node.children then
    return
  end

  for _, child in ipairs(node.children) do
    local suffix = child.parent.parent and config.separator or ""
    local icon = config.icons[navic.adapt_lsp_num_to_str(child.kind)] or ""
    local highlight = "NavicIcons" .. navic.adapt_lsp_num_to_str(child.kind)

    local path_pre_child = current_path .. suffix
    local path_post_child = path_pre_child .. icon .. child.name

    local lnum = child.scope.start.line or 0
    local col = child.scope.start.character + 1 or 0 -- 1 is needed to place cursor correctly

    child.hl_tree = utils.deep_copy(node.hl_tree)
    local hl = { { #path_pre_child, #path_pre_child + #icon }, highlight }
    table.insert(child.hl_tree, hl)

    local symbol_entry = {
      value = path_post_child,
      lnum = lnum,
      col = col,
      highlights = child.hl_tree,
    }
    table.insert(symbol_entries, symbol_entry)
    traverse(child, path_post_child, symbol_entries, config)
  end
end

local M = {}

function M.get_symbol_paths(bufnr, config)
  local symbol_tree = navic.get_tree(bufnr)
  if not symbol_tree then
    return {}
  end
  symbol_tree.hl_tree = {}

  local symbol_entries = {}
  traverse(symbol_tree, "", symbol_entries, config)
  return symbol_entries
end

return M
