local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet

local function date() return {os.date("%Y-%m-%d %H:%M:%S")} end

ls.add_snippets(nil, {
  all = {
    s({
      trig = "nmmn",
      namr = "if 'name' == __main__",
      dscr = 'if __name__ == "__main__":',
    },
      {
        t({'if __name__ == "__main__":', ''}),
        t('    '), i(0, "main"), t('()'),
      }),
  -- TODO: If within a function, get the function parameters and format their types with numpydoc format.
  -- TODO: Use treesitter to get the function parameters and auto-document their types.
  s({
    trig = "dstr",
    namr = "",
    dscr = 'Add a docstring for the function.',
  },
    {
      t('"""'), i(0, "FUNCTION DESCRIPTION HERE"), t({''}),
      t({'', '"""'}),
      t({'Parameters', '----------'}),
      t({"x : type", ''}),
      t({"Description of parameter `x`.", ""}),
      t({"y", ""}),
      t({"Description of parameter `y` (with type not specified).", ""})
    }),
  }
})
