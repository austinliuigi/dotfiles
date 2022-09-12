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
* fmt: https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#fmt
]]


local snippets = {
}

return snippets