local ls = require("luasnip")
local s = ls.s -- snippet:     s(<string: trig>, <table: nodes>)
local t = ls.t -- text node:   t(<string|table: text>)
local i = ls.i -- insert node: i(<int: jump_number>, [string|table: placeholder_text])

local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

--[[ 
* if multiple insert nodes with same placeholder number, all but one are rendered useless
* if there are multiple jumpable nodes, but a jump_number is skipped (e.g. there is i(0) and i(2) but no i(1)),
  any node after the skipped jump_number will do nothing
]]


local snippets = {
  s("snippet", fmt([[
    local ls = require("luasnip")
    local s = ls.s -- snippet:     s(<string: trig>, <table: nodes>)
    local t = ls.t -- text node:   t(<string|table: text>)
    local i = ls.i -- insert node: i(<int: jump_number>, [string|table: placeholder_text])

    local c = ls.choice_node
    local f = ls.function_node
    local d = ls.dynamic_node
    local sn = ls.snippet_node

    local fmt = require("luasnip.extras.fmt").fmt
    local rep = require("luasnip.extras").rep

    local snippets = {{
      {}
    }}

    return snippets
  ]], {
    i(0)
  }), {
    condition = function()
      local dir = vim.fn.split(vim.fn.expand("%:p:h"), "/")
      return dir[#dir] == "snippets"
    end,
    show_condition = function()
      local dir = vim.fn.split(vim.fn.expand("%:p:h"), "/")
      return dir[#dir] == "snippets"
    end,
  }),

  s("snip", fmt([=[
    s("{}", fmt([[
      {}
    ]], {{
      {}
    }})),
  ]=], {
    i(1),
    i(2),
    i(0),
  }), {
    condition = function()
      local dir = vim.fn.split(vim.fn.expand("%:p:h"), "/")
      return dir[#dir] == "snippets"
    end,
    show_condition = function()
      local dir = vim.fn.split(vim.fn.expand("%:p:h"), "/")
      return dir[#dir] == "snippets"
    end,
  }),
}

return snippets
