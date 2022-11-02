-- global init --
o = vim.o
bo = vim.bo
wo = vim.wo

require 'basic'
require 'keymaps'
require 'packages'
require 'completion'
require 'rust'
require 'tree'

-- Neovide Configuration
if vim.g.neovide ~= nil then
  vim.opt.guifont = { "Fantasque Sans Mono", ":h16"}
  vim.g.neovide_scroll_animation_length = 0.3
  -- vim.g.neovide_fullscreen = true
end

require('lualine').setup {
  options = {
    theme = 'gruvbox-material'
  }
}

o.background = 'dark'
vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_better_performance = 1
vim.cmd("colorscheme gruvbox-material")

-- Bufferline --
require("bufferline").setup{
  options = {
    separator_style = "slant",
    diagnostics = "nvim_lsp",
  
    offsets = {
        {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
        }
    }
  }
}

-- TreeSettter Config
local configs = require'nvim-treesitter.configs'
configs.setup {
  ensure_installed = {"lua", "rust", "c", "go", "json", "html", "yaml"},
  sync_install = false,
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true }
}

-- LSP
require("mason").setup()
local nvim_lsp = require'lspconfig' 


-- Autopairs
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

-- TabNine
local tabnine = require('cmp_tabnine.config')
tabnine:setup({max_lines = 1000, max_num_results = 20, sort = true})

-- hop
local hop = require('hop')
hop.setup {}

-- Indent lines
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}

-- Better Escape
require("better_escape").setup {
    mapping = {"jk", "jj"}, -- a table with mappings to use
    timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
    clear_empty_lines = false, -- clear line after escaping if there is only whitespace
    keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
}

-- Terminal
require('toggleterm').setup()

-- Telescope
actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    layout_strategy = "vertical",
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-e>"] = actions.close,
      }
    }
  }
}
