-- global init --
o = vim.o
bo = vim.bo
wo = vim.wo

-- basic setups --
o.termguicolors = true
o.syntax = 'on'
o.errorbells = false
o.smartcase = true
o.showmode = false
o.updatetime = 300
o.signcolumn = 'yes'
o.backup = false
o.backup = false
o.writebackup = false
bo.swapfile = false
o.backup = false
o.undodir = vim.fn.stdpath('config') .. '/undodir'
o.undofile = true
o.incsearch = true
o.hidden = true
o.completeopt='menuone,noinsert,noselect'
bo.autoindent = true
bo.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.linespace = 8 
wo.number = true
wo.relativenumber = true
wo.signcolumn = 'yes'
wo.wrap = false

-- leader --
vim.g.mapleader = ' '

-- key_mapping --
local key_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end

function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

fsOptions = function()
  local name = string.sub(vim.api.nvim_buf_get_name(0), -10)
  if string.starts(name, "NvimTree") == false then
    return 
  end

  local popup = require('popup')
  nt_api = require("nvim-tree.api") 
  
  switch = {
    ["create"] = function() nt_api.fs.create() end,
    ["rename"] = function() nt_api.fs.rename() end,
    ["delete"] = function() nt_api.fs.remove() end,
  }
  
  popup.create({ "create", "rename", "delete" }, {
    line = "cursor+1",
    col = "cursor+1",
    padding = {0, 1, 0, 1},
    enter = true,
    cursorline = true,
    callback = function(win_id, sel) switch[string.gsub(sel, "%s+", "")]() end,
})
end

key_mapper('n', '<leader>io', ':lua fsOptions()<CR>')
-- Telescope
key_mapper('n', '<C-p>', ':lua require"telescope.builtin".find_files()<CR>')
key_mapper('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
key_mapper('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
key_mapper('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')

-- nvim tree
key_mapper('n', '<leader>tt', ':lua require"nvim-tree".toggle(true)<CR>')
key_mapper('n', '<leader>tf', ':lua require"nvim-tree".find_file()<CR>')


-- barbar
key_mapper('n', '<leader>bq', '<Cmd>BufferClose<CR>')
key_mapper('n', '<leader>bp', '<Cmd>BufferPin<CR>')
key_mapper('n', '<leader>bs', '<Cmd>BufferPick<CR>')
key_mapper('n', '<C-h>', '<Cmd>BufferPrevious<CR>')
key_mapper('n', '<C-l>', '<Cmd>BufferNext<CR>')

-- rust building
key_mapper('n', '<leader>rr', '<Cmd>RustRunnable<CR>')
key_mapper('n', '<leader>rb', '<Cmd>term cargo build<CR>')

-- additional
key_mapper('n', '<S-Q>', '<Cmd>q<CR>')

-- main config --
--
local vim = vim

local execute = vim.api.nvim_command
local fn = vim.fn

-- ensure that packer is installed
--local install_path = fn.stdpath('data')..'site/pack/packer/opt/packer.nvim'
--if fn.empty(fn.glob(install_path)) > 0 then
--  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
--  execute 'packadd packer.nvim'
--end

-- vim.cmd('packadd packer.nvim')

local packer = require'packer'
local util = require'packer.util'

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

--startup and add configure plugins
--
packer.startup(function()
  local use = use
  -- list of the plugins
  use 'nvim-treesitter/nvim-treesitter'
  use 'sheerun/vim-polyglot'
  use 'romgrk/barbar.nvim'
  use "lukas-reineke/indent-blankline.nvim"
  use 'mfussenegger/nvim-dap'
  -- themes
  use 'ellisonleao/gruvbox.nvim'
  use 'overcache/NeoSolarized'
  
  -- LSP
  use 'neovim/nvim-lspconfig'
  
  -- Rust
  use 'rust-lang/rust.vim'
  use 'simrat39/rust-tools.nvim'
  use 'preservim/tagbar'
  -- Debugging
  use 'mfussenegger/nvim-dap'

  -- Telescope
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/telescope.nvim'
  use 'jremmen/vim-ripgrep'

  -- CMP
  use 'onsails/lspkind.nvim'
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer", 
      "hrsh7th/cmp-nvim-lsp",
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'octaltree/cmp-look', 
      'hrsh7th/cmp-path', 
      'f3fora/cmp-spell', 
      'hrsh7th/cmp-emoji'
    }
  }
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }
  use {
    'tzachar/cmp-tabnine',
    run = './install.sh',
    requires = 'hrsh7th/nvim-cmp'
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
  }
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({})
    end
  })
  end
)

-- colorscheme setup
--vim.g.colors_name = 'NeoSolarized'
--vim.g.neosolarized_contrast = 'low'
--vim.g.neosolarized_visability = 'normal'
--vim.g.neosolarized_italic = 1
require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = true,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
vim.g.colors_name = 'gruvbox'

o.background = 'dark'

-- treesettter config
local configs = require'nvim-treesitter.configs'
configs.setup {
  ensure_installed = {"lua", "rust", "c", "json", "html", "yaml"},
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  }
}

-- rust setup
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
require('rust-tools').inlay_hints.set()
require('rust-tools').inlay_hints.enable()


-- CMP Config
local cmp = require('cmp')

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
