local packer = require'packer'
local util = require'packer.util'

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

--startup and add configure plugins
--
packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  
  -- list of the plugins
  use 'nvim-treesitter/nvim-treesitter'
  use 'romgrk/barbar.nvim'
  use "lukas-reineke/indent-blankline.nvim"
  use 'max397574/better-escape.nvim'
  -- themes
  use 'ellisonleao/gruvbox.nvim'
  use 'sainnhe/everforest' 
  
  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'mfussenegger/nvim-jdtls'
  
  -- Rust
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

  -- Miscellaneous --
  use 'tpope/vim-commentary' 
  use 'nvim-lualine/lualine.nvim'
  use 'akinsho/toggleterm.nvim'
  
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
