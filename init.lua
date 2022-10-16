-- global init --
o = vim.o
bo = vim.bo
wo = vim.wo

require 'basic'
require 'keymaps'
require 'packages'

if vim.g.neovide ~= nil then
  -- vim.opt.guifont = { "Hack Nerd Font Mono", ":h14"}
  -- vim.opt.guifont = { "JetBrains Mono NL", ":h15"}
  vim.opt.guifont = { "Fantasque Sans Mono", ":h16"}

  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_fullscreen = true
end

require('lualine').setup {
  options = {
    theme = 'everforst'
  }
}

-- require("gruvbox").setup({
--   undercurl = true,
--   underline = true,
--   bold = true,
--   italic = true,
--   strikethrough = true,
--   invert_selection = false,
--   invert_signs = false,
--   invert_tabline = false,
--   invert_intend_guides = false,
--   inverse = true, -- invert background for search, diffs, statuslines and errors
--   contrast = "soft", -- can be "hard", "soft" or empty string
--   overrides = {},
--   dim_inactive = false,
--   transparent_mode = false,
-- })
-- vim.g.colors_name = 'gruvbox'
-- o.background = 'dark'

vim.cmd("colorscheme everforest")
o.background = 'dark'

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
local nvim_lsp = require'lspconfig' 

-- rust setup
local rt = require("rust-tools")

rt.setup({
  tools = {
    autoSetHints = true, 
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_refix = ""
    }
  },
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    settings = {
        -- to enable rust-analyzer settings visit:
        -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ["rust-analyzer"] = {
            -- enable clippy on save
            checkOnSave = {
                command = "clippy"
            },
        }
    }
  },
})
require('rust-tools').inlay_hints.set()
require('rust-tools').inlay_hints.enable()


-- CMP Config
local cmp = require('cmp')
vim.o.shortmess = vim.o.shortmess .. "c"

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

cmp.setup {

    formatting = {
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = require("lspkind").presets.default[vim_item.kind] ..
                                " " .. vim_item.kind
            -- set a name for each source
            vim_item.menu = ({
                buffer = "[Buf]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                cmp_tabnine = "[Tn]",
            })[entry.source.name]
            return vim_item
        end
    },
    mapping = {
        ['<Tab>'] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
        ['<S-Tab>'] = function(fallback)
          if cmp.visible() then
            print("visible -")
            cmp.select_prev_item()
          else
            print("NOT visible -")
            fallback()
          end
        end,
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        }),
    },
    -- TODO: try to remove or fix this line
    snippet = { 
      expand = function(args)
        require'luasnip'.lsp_expand(args.body)
      end
    },
    sources = {
        {name = 'nvim_lsp'}, 
        {name = 'buffer', keyword_length = 4},
        {name = "luasnip"},
        {name = 'cmp_tabnine', keyword_length = 3} 
    },
    completion = {completeopt = 'menu,menuone,noinsert'}
}

-- Autopairs
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

-- TabNine
local tabnine = require('cmp_tabnine.config')
tabnine:setup({max_lines = 1000, max_num_results = 20, sort = true})

-- Tree setup
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
 },
})

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
