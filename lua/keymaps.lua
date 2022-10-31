local P = {}
keymaps = P
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

-- Telescope
key_mapper('n', '<C-p>', ':lua require"telescope.builtin".find_files()<CR>')
key_mapper('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
key_mapper('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
key_mapper('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')
key_mapper('n', 'gk', ":lua print('Hello')<CR>")
key_mapper('n', '<leader>ct', '<Cmd>TagbarToggle<CR>')

--LSP
key_mapper('n', '<C-]>', ':lua vim.lsp.buf.definition()<CR>')
key_mapper('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>')
key_mapper('n', '<S-R>', ':lua vim.lsp.buf.references()<CR>')
key_mapper('n', '<S-H>', ':lua vim.lsp.buf.hover()<CR>')
key_mapper('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
key_mapper('n', '<leader>nc', ':lua vim.lsp.buf.rename()<CR>')

-- nvim tree
key_mapper('n', '<leader>tt', ':lua require"nvim-tree".toggle(true)<CR>')
key_mapper('n', '<leader>tf', ':lua require"nvim-tree".find_file()<CR>')

-- bufferline
key_mapper('n', '<leader>bq', '<Cmd>BufferLineCloseRight<CR>')
key_mapper('n', '<leader>bp', '<Cmd>BufferLineTogglePin<CR>')
key_mapper('n', '<leader>bs', '<Cmd>BufferLinePick<CR>')
key_mapper('n', '<C-h>', '<Cmd>BufferLineCyclePrev<CR>')
key_mapper('n', '<C-l>', '<Cmd>BufferLineCycleNext<CR>')

-- Rust
function P.map_rust_keys(bufnr)
  key_mapper('n', '<leader>rr', '<Cmd>RustRunnable<CR>')
  key_mapper('n', '<leader>rb', '<cmd>term cargo build<cr>')
  key_mapper('n', '<leader>rc', '<cmd>term cargo check<cr>')
  key_mapper('n', '<leader>rt', '<cmd>term cargo test<cr>')
end

-- Java
function P.map_java_keys(bufnr)
  local spring_boot_run = 'mvn spring-boot:run -Dspring-boot.run.profiles=local'
  local command = ':lua require("toggleterm").exec("' .. spring_boot_run .. '")<CR>'
  key_mapper('n', '<leader>sr', command)
  key_mapper('n', '<leader>oi', ':lua require("jdtls").organize_imports()<CR>')
  key_mapper('n', '<leader>jc', ':lua require("jdtls).compile("incremental")')
end

-- hop
key_mapper('n', 'f', '<cmd>HopWordCurrentLineAC<cr>')
key_mapper('n', '<S-F>', '<cmd>HopWordCurrentLineBC<cr>')
key_mapper('n', '<leader>hp', '<cmd>HopPattern<cr>')
key_mapper('n', 'gt', '<cmd>HopLine<cr>')
-- additional
key_mapper('n', '<leader>sf', ':w<CR>')
key_mapper('n', '<S-Q>', '<Cmd>q<CR>')

return P
