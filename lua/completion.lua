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
  enable = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
  end,
  snippet = { 
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end
  },
  sources = {
      {name = 'nvim_lsp'}, 
      {name = 'buffer', keyword_length = 3},
      {name = "luasnip", keyword_length = 2},
      {name = 'cmp_tabnine', keyword_length = 3},
  },

  window = {
    documentation = cmp.config.window.bordered()
  },

  completion = {completeopt = 'menu,menuone,noinsert'},
  preselect = cmp.PreselectMode.None,
  
  formatting = {
      format = function(entry, vim_item)
          -- fancy icons and a name of kind
          vim_item.kind = require("lspkind").presets.default[vim_item.kind] ..
                              " " .. vim_item.kind
          -- set a name for each source
          vim_item.menu = ({
              nvim_lsp = "+",
              buffer = "#",
              luasnip = "-",
              cmp_tabnine = "[Tn]",
          })[entry.source.name]
          return vim_item
      end
  },
  mapping = {
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true
      }),
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,
      ['<C-j>'] = function(fallback)
        if cmp.visible() then
          cmp.scroll_docs(4)
        else
          fallback()
        end
      end,
      ['<C-k>'] = function(fallback)
        if cmp.visible() then
          cmp.scroll_docs(-4)
        else
          fallback()
        end
      end,
      ['<C-Space>'] = cmp.mapping.complete(),
  },
}

require("cmp").setup({
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
  end
})

require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
  sources = {
    { name = "dap" },
  },
})
