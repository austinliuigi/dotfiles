require("tinbar")

vim.keymap.set({"n"}, "<leader>tf", function() require("tinbar"):toggle_filepath_type() end, {})
