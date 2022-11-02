local P = {}
keymaps = P
-- leader --
vim.g.mapleader = ' '

-- key_mapping --
local key_map = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end

function git_commit_all()
  vim.ui.input({ prompt = 'Msg: ' }, function(input)
    io.popen("git add src/* && git commit -am '" .. input .. "'")
  end)
end

function git_commit_push_all()
  vim.ui.input({ prompt = 'Msg: ' }, function(input)
    io.popen("git add src/* && git commit -am '" .. input .. "' && git push")
  end)
end

-- Telescope
key_map('n', '<C-p>', ':lua require"telescope.builtin".find_files()<CR>')
key_map('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
key_map('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
key_map('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')
key_map('n', '<leader>ct', '<Cmd>TagbarToggle<CR>')

-- Git
key_map('n', '<leader>gc', ':lua git_commit_all()<CR>')
key_map('n', '<leader>ga', ':lua git_commit_push_all()<CR>')

--LSP
key_map('n', '<C-]>', ':lua vim.lsp.buf.definition()<CR>')
key_map('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>')
key_map('n', '<S-R>', ':lua vim.lsp.buf.references()<CR>')
key_map('n', '<S-H>', ':lua vim.lsp.buf.hover()<CR>')
key_map('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
key_map('n', '<leader>nc', ':lua vim.lsp.buf.rename()<CR>')

-- nvim tree
key_map('n', '<leader>tt', ':lua require"nvim-tree".toggle(true)<CR>')
key_map('n', '<leader>tf', ':lua require"nvim-tree".find_file()<CR>')

-- bufferline
key_map('n', '<leader>bq', '<Cmd>bdelete!<CR>')
key_map('n', '<leader>bp', '<Cmd>BufferLineTogglePin<CR>')
key_map('n', '<leader>bs', '<Cmd>BufferLinePick<CR>')
key_map('n', '<C-h>', '<Cmd>BufferLineCyclePrev<CR>')
key_map('n', '<C-l>', '<Cmd>BufferLineCycleNext<CR>')

-- Rust
function P.map_rust_keys(bufnr)
  key_map('n', '<leader>rr', '<Cmd>RustRunnable<CR>')
  key_map('n', '<leader>rb', '<cmd>term cargo build<cr>')
  key_map('n', '<leader>rc', '<cmd>term cargo check<cr>')
  key_map('n', '<leader>rt', '<cmd>term cargo test<cr>')
end

-- Java
local spring_boot_run = 'mvn spring-boot:run -Dspring-boot.run.profiles=local'
local command = ':lua require("toggleterm").exec("' .. spring_boot_run .. '")<CR>'
key_map('n', '<leader>sr', command)
key_map('n', '<leader>oi', ':lua require("jdtls").organize_imports()<CR>')
key_map('n', '<leader>jc', ':lua require("jdtls).compile("incremental")')
function P.map_java_keys(bufnr)
end

-- hop
key_map('n', 'f', '<cmd>HopWordCurrentLineAC<cr>')
key_map('n', '<S-F>', '<cmd>HopWordCurrentLineBC<cr>')
key_map('n', '<leader>hp', '<cmd>HopPattern<cr>')
key_map('n', 'gt', '<cmd>HopLine<cr>')
-- additional
key_map('n', '<leader>sf', ':w<CR>')
key_map('n', '<S-Q>', '<Cmd>q<CR>')

return P
