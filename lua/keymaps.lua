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
function P.map_lsp_keys() 
  key_map('n', '<C-]>', ':lua vim.lsp.buf.definition()<CR>')
  key_map('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>')
  key_map('n', '<S-R>', ':lua vim.lsp.buf.references()<CR>')
  key_map('n', '<S-H>', ':lua vim.lsp.buf.hover()<CR>')
  key_map('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
  key_map('n', '<leader>nc', ':lua vim.lsp.buf.rename()<CR>')
  key_map('n', '<leader>fr', ':lua require"telescope.builtin".lsp_references()')
end

-- nvim tree
key_map('n', '<leader>tt', ':lua require"nvim-tree".toggle(true)<CR>')
key_map('n', '<leader>tf', ':lua require"nvim-tree".find_file()<CR>')

-- bufferline
key_map('n', '<leader>bq', '<Cmd>bdelete!<CR>')
key_map('n', '<leader>bp', '<Cmd>BufferLineTogglePin<CR>')
key_map('n', '<leader>bs', '<Cmd>BufferLinePick<CR>')
key_map('n', '<C-h>', '<Cmd>BufferLineCyclePrev<CR>')
key_map('n', '<C-l>', '<Cmd>BufferLineCycleNext<CR>')

-- Terminal
key_map('', '<leader>tc', '<Cmd>ToggleTermToggleAll<CR>')

-- Debugging 

function debug_open_centered_scopes()
  local widgets = require'dap.ui.widgets'
  widgets.centered_float(widgets.scopes)
end

key_map('n', 'gs', ':lua debug_open_centered_scopes()<CR>')
key_map('n', '<F5>', ':lua require"dap".continue()<CR>')
key_map('n', '<F8>', ':lua require"dap".step_over()<CR>')
key_map('n', '<F7>', ':lua require"dap".step_into()<CR>')
key_map('n', '<S-F8>', ':lua require"dap".step_out()<CR>')
key_map('n', '<leader>b', ':lua require"dap".toggle_breakpoint()<CR>')
key_map('n', '<leader>B', ':lua require"dap".set_breakpoint(vim.fn.input("Condition: "))<CR>')
key_map('n', '<leader>bl', ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log: "))<CR>')
key_map('n', '<leader>dr', ':lua require"dap".repl.open()<CR>')

-- Java

-- Rust
function P.map_rust_keys(bufnr)
  P.map_lsp_keys()
  key_map('n', '<leader>rr', '<Cmd>RustRunnable<CR>')
  key_map('n', '<leader>rb', '<cmd>term cargo build<cr>')
  key_map('n', '<leader>rc', '<cmd>term cargo check<cr>')
  key_map('n', '<leader>rt', '<cmd>term cargo test<cr>')
end

function P.run_command_method_test()
  local node_utils = require'node-utils'
  local method_name = node_utils.get_current_full_method_name("\\#")
  local mvn_run = 'mvn test -Dmaven.surefire.debug -Dtest="' .. method_name .. '"' 
  vim.cmd('term ' .. mvn_run)
end

function P.run_command_class_test()
  local node_utils = require'node-utils'
  local class_name = node_utils.get_current_full_class_name()
  local mvn_run = 'mvn test -Dmaven.surefire.debug -Dtest="' .. class_name .. '"' 
  vim.cmd('term ' .. mvn_run)
end

-- Java
function P.map_java_keys(bufnr)
  P.map_lsp_keys()
  key_map('n', '<leader>oi', ':lua require("jdtls").organize_imports()<CR>')
  key_map('n', '<leader>jc', ':lua require("jdtls).compile("incremental")')
end

-- hop
key_map('n', 'f', '<cmd>HopWordCurrentLineAC<cr>')
key_map('n', '<S-F>', '<cmd>HopWordCurrentLineBC<cr>')
key_map('n', '<leader>hp', '<cmd>HopPattern<cr>')
key_map('n', 'gt', '<cmd>HopLine<cr>')
-- additional
key_map('n', '<leader>sf', ':w<CR>')
key_map('n', '<S-Q>', '<Cmd>q<CR>')


-- run debug
function get_test_runner(test_name, debug)
  if debug then
    return 'mvn test -Dmaven.surefire.debug -Dtest="' .. test_name .. '"' 
  end
  return 'mvn test -Dtest="' .. test_name .. '"' 
end

function run_java_test_method(debug)
  local utils = require'utils'
  local method_name = utils.get_current_full_method_name("\\#")
  vim.cmd('term ' .. get_test_runner(method_name, debug))
end

function run_java_test_class(debug)
  local utils = require'utils'
  local class_name = utils.get_current_full_class_name()
  vim.cmd('term ' .. get_test_runner(class_name, debug))
end

function get_spring_boot_runner(profile, debug)
  local debug_param = ""
  if debug then
    debug_param = ' -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005" '
  end 

  local profile_param = ""
  if profile then
    profile_param = " -Dspring-boot.run.profiles=" .. profile .. " "
  end

  return 'mvn spring-boot:run ' .. profile_param .. debug_param
end

function run_spring_boot(debug)
  vim.cmd('term ' .. get_spring_boot_runner("local", debug))
end

vim.keymap.set("n", "<leader>tm", function() run_java_test_method() end)
vim.keymap.set("n", "<leader>TM", function() run_java_test_method(true) end)
vim.keymap.set("n", "<leader>tc", function() run_java_test_class() end)
vim.keymap.set("n", "<leader>TC", function() run_java_test_class(true) end)
vim.keymap.set("n", "<F9>", function() run_spring_boot() end)
vim.keymap.set("n", "<F10>", function() run_spring_boot(true) end)

function attach_to_debug()
  local dap = require('dap')
  dap.configurations.java = {
    {
      type = 'java';
      request = 'attach';
      name = "Attach to the process";
      hostName = 'localhost';
      port = '5005';
    },
  }
  dap.continue()
end 

key_map('n', '<leader>da', ':lua attach_to_debug()<CR>')
return P
