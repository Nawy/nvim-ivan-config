
-- RUST Setup
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
      keymaps.map_rust_keys(bufnr)
      
      require "lsp_signature".on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        floating_window_above_cur_line = false,
        padding = '',
        handler_opts = {
          border = "rounded"
        }
      }, bufnr)
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

