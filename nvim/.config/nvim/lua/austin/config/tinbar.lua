local toggle_key = require("austin.keymaps").toggle_key

require("tinbar")
vim.keymap.set({"n"}, toggle_key.."f", function() require("tinbar"):toggle_filepath_type() end, {})
