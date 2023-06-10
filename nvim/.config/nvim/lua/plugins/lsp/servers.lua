local lspconfig = require("lspconfig")
local util = lspconfig.util

local servers = {}

servers.clangd = {}

local python_root_files = {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  'pyrightconfig.json',
  '.git',
}
servers.pyright = {
  root_dir = util.root_pattern(unpack(python_root_files))
}

servers.lua_ls = {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {
          "vim"
        }
      }
    }
  }
}

servers.yamlls = {}

-- local latex_forwardsearch_executable, latex_forwardsearch_args
-- if vim.fn.has("macos") then
--   latex_forwardsearch_executable = "/Applications/Skim.app/Contents/SharedSupport/displayline"
--   latex_forwardsearch_args = {"-g", "-b", "%l", "%p", "%f",}
-- elseif vim.fn.has("linux") then
--   latex_forwardsearch_executable = "zathura"
--   latex_forwardsearch_args = {"--synctex-forward", "%l:1:%f", "%p"}
-- end
--
-- servers.texlab = {
--   settings = {
--     texlab = {
--       auxDirectory = ".",
--       bibtexFormatter = "texlab",
--       build = {
--         args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "-shell-escape","%f" },
--         executable = "latexmk",
--         forwardSearchAfter = true,
--         onSave = true
--       },
--       chktex = {
--         onEdit = false,
--         onOpenAndSave = false
--       },
--       diagnosticsDelay = 300,
--       formatterLineLength = 80,
--       forwardSearch = {
--         executable = latex_forwardsearch_executable,
--         args = latex_forwardsearch_args
--       },
--       latexFormatter = "latexindent",
--       latexindent = {
--         modifyLineBreaks = false
--       }
--     }
--   }
-- }

return servers
