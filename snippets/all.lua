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


-- define the function used by the snippet 
local date = function() return {os.date('%Y-%m-%d %H:%M')} end

ls.add_snippets(nil, {
  all = {
    -- add date to document
    s({
      trig = "date",
      namr = "Date",
      dscr = "Date in the form of YYYY-MM-DD",
    }, {
        f(date, {}),
      }),
    s({
      trig = "trans",
      namr = "trans",
      dscr = "New WF transaction json entry",
    }, {
        t('{"deposit_date": "'), i(1, "deposit_date"), t({'",', ""}),
        t('"transaction_date": "'), i(2, "transaction_date"), t({'",', ""}),
        t('"total": '), i(3, "$999999.99"), t({"", ""}),
        t({'"checks": [', "", }),
        i(0, "COPY_PASTE_CHECKS_AND_MACRO_AWAY"),
        t({"", "]", "", "}"})
      }),
  }
})
