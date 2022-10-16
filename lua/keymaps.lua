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

-- barbar
key_mapper('n', '<leader>bq', '<Cmd>BufferClose<CR>')
key_mapper('n', '<leader>bp', '<Cmd>BufferPin<CR>')
key_mapper('n', '<leader>bs', '<Cmd>BufferPick<CR>')
key_mapper('n', '<C-h>', '<Cmd>BufferPrevious<CR>')
key_mapper('n', '<C-l>', '<Cmd>BufferNext<CR>')

-- rust building
key_mapper('n', '<leader>rr', '<Cmd>RustRunnable<CR>')
key_mapper('n', '<leader>rb', ':lua require"toggleterm".exec("cargo build", 1, 12)<cr>')
key_mapper('n', '<leader>rc', '<cmd>term cargo check<cr>')
key_mapper('n', '<leader>rt', '<cmd>term cargo test<cr>')

-- additional
key_mapper('n', '<leader>sf', ':w<CR>')
key_mapper('n', '<S-Q>', '<Cmd>q<CR>')

