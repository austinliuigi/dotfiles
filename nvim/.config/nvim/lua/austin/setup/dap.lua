local map = vim.keymap.set

map('n', "<Left>",  function() return require("dap").step_back() end, {})
map('n', "<Down>",  function() return require("dap").step_out() end,  {})
map('n', "<Up>",    function() return require("dap").step_into() end, {})
map('n', "<Right>", function() return require("dap").step_over() end, {})

map('n', "<S-Left>",  function() return require("dap").reverse_continue() end, {})
map('n', "<S-Down>",  function() return require("dap").terminate() end,  {})
map('n', "<S-Up>",    function() return require("dap").repl.toggle() end, {})
map('n', "<S-Right>", function() return require("dap").continue() end, {})

map('n', "<S-CR>", function() return require("dap").toggle_breakpoint() end, {})
map('n', "<C-CR>", function() return require("dap").set_breakpoint(vim.fn.input("Breakpoint Condition: ")) end, {})
map('n', "<leader>tb", function() return require("dap").toggle_breakpoint() end, {})
map('n', "<leader>tB", function() return require("dap").set_breakpoint(vim.fn.input("Breakpoint Condition: ")) end, {})
-- map('n', "<leader>tB", function() return vim.ui.input({ prompt = 'Breakpoint Condition: ' }, function(input) return require('dap').toggle_breakpoint(input) end) end, {})
