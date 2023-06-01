local servers = {}

servers.clangd = {}

servers.julials = {}

servers.pyright = {}

servers.lua_ls = {
  settings = {
    Lua = {
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
