# telescope-navic.nvim
[nvim-navic](https://github.com/SmiteshP/nvim-navic) symbol path picker

![nvim-navic telescope picker preview](https://github.com/user-attachments/assets/8696cea8-e1df-4c43-896f-a3b88a5e1667)

## Requirements
- Neovim >= 0.9.5
- [nvim-navic](https://github.com/SmiteshP/nvim-navic) (required)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) (required)
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)

## Installation
### [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "vifrik/telescope-navic.nvim",
      dependencies = {
        {
          "SmiteshP/nvim-navic",
          opts = { lsp = { auto_attach = true } }, -- can also be attached manually, see nvim-navic
        },
      },
    },
  },
}

function M.config()
  local telescope = require("telescope")

  telescope.setup({
    color_devicons = true, -- needed for highlighting to work
    <telescope_settings...>
  })

  telescope.load_extension("navic")

  vim.keymap.set("n", "<Leader>fn", "<Cmd>Telescope navic<CR>")
end

return M
```

## Customize
```lua
navic_telescope.setup({
    icons = {
        File          = "󰈙 ",
        Module        = " ",
        Namespace     = "󰌗 ",
        Package       = " ",
        Class         = "󰌗 ",
        Method        = "󰆧 ",
        Property      = " ",
        Field         = " ",
        Constructor   = " ",
        Enum          = "󰕘",
        Interface     = "󰕘",
        Function      = "󰊕 ",
        Variable      = "󰆧 ",
        Constant      = "󰏿 ",
        String        = "󰀬 ",
        Number        = "󰎠 ",
        Boolean       = "◩ ",
        Array         = "󰅪 ",
        Object        = "󰅩 ",
        Key           = "󰌋 ",
        Null          = "󰟢 ",
        EnumMember    = " ",
        Struct        = "󰌗 ",
        Event         = " ",
        Operator      = "󰆕 ",
        TypeParameter = "󰊄 ",
    },
    separator = " > ",
})
```

telescope-navic.nvim, just like nvim-navic uses highlight groups to do highlighting. Define these highlights to enable highlighting.
```lua
local set_hl = vim.api.nvim_set_hl

set_hl(0, "NavicIconsFile", { link = "Structure" })
set_hl(0, "NavicIconsModule", { link = "Structure" })
set_hl(0, "NavicIconsNamespace", { link = "Structure" })
set_hl(0, "NavicIconsPackage", { link = "Structure" })
set_hl(0, "NavicIconsClass", { link = "Structure" })
set_hl(0, "NavicIconsMethod", { link = "Function" })
set_hl(0, "NavicIconsProperty", { link = "Identifier" })
set_hl(0, "NavicIconsField", { link = "Identifier" })
set_hl(0, "NavicIconsConstructor", { link = "Structure" })
set_hl(0, "NavicIconsEnum", { link = "Type" })
set_hl(0, "NavicIconsInterface", { link = "Type" })
set_hl(0, "NavicIconsFunction", { link = "Function" })
set_hl(0, "NavicIconsVariable", { link = "Identifier" })
set_hl(0, "NavicIconsConstant", { link = "Constant" })
set_hl(0, "NavicIconsString", { link = "String" })
set_hl(0, "NavicIconsNumber", { link = "Number" })
set_hl(0, "NavicIconsBoolean", { link = "Boolean" })
set_hl(0, "NavicIconsArray", { link = "Structure" })
set_hl(0, "NavicIconsObject", { link = "Structure" })
set_hl(0, "NavicIconsKey", { link = "Identifier" })
set_hl(0, "NavicIconsNull", { link = "Special" })
set_hl(0, "NavicIconsEnumMember", { link = "Constant" })
set_hl(0, "NavicIconsStruct", { link = "Structure" })
set_hl(0, "NavicIconsEvent", { link = "Type" })
set_hl(0, "NavicIconsOperator", { link = "Operator" })
set_hl(0, "NavicIconsTypeParameter", { link = "TypeDef" })
set_hl(0, "NavicText", { link = "Normal" })
set_hl(0, "NavicSeparator", { link = "Normal" })
```
