local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  error("This extension requires telescope.nvim (https://github.com/nvim-telescope/telescope.nvim)")
end

local navic_picker = require("telescope-navic").navic_picker

return telescope.register_extension({
  exports = {
    navic = navic_picker,
  },
})
