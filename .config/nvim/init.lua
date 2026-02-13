-- very early stuff
require("includes.preinits")

-- plugins MUST be first
require("includes.plugins")

-- plugin configs
require("includes.lualine")
require("includes.nvimtree")
require("includes.ibl")
require("includes.mason")
require("includes.treesitter")
require("includes.cmp")
require("includes.lsp")

-- core vim options
require("includes.options")

-- ui
require("includes.colorscheme")

-- keymaps
require("includes.keybindings")

