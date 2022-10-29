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

local snippets = {
  s("main", fmt([[
    def main():
      {}

    if __name__ == "__main__":
      main()
  ]], {
    i(0)
  })),
}

return snippets
