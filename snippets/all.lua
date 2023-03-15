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
local date = function() return {os.date('%Y-%m-%d')} end

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
      trig = "link",
      namr = "markdown_link",
      dscr = "Create markdown link [txt](url)"
    },
      {
        t('['),
        i(1),
        t(']('),
        f(function(_, s)
          return s.env.TM_SELECTED_TEXT[1] or {}
        end, {}),
        t(')'),
        i(0),
      }),
    s({
      trig = "meta",
      namr = "Metadata",
      dscr = "Yaml metadata format for markdown"
    },
      {
        t({"---",
          "title: "}), i(1, "note_title"), t({"",
          "author: "}), i(2, "author"), t({"",
          "date: "}), f(date, {}), t({"",
          "categories: ["}), i(3, ""), t({"]",
          "lastmod: "}), f(date, {}), t({"",
          "tags: ["}), i(4), t({"]",
          "comments: true",
          "---", ""}),
        i(0)
      }),
    s({
      trig = "histintro",
    },
      {
        t({"The patient named "}),
        i(1, "PATIENT_NAME"),
        t({", a "}),
        i(2, "RIGHT_OR_LEFT"),
        t({"-hand dominant "}),
        i(3, "MALE_OR_FEMALE"),
        t({", presented today to my "}),
        i(0, "LOCATION"),
        t({" office for a comprehensive med-legal evaluation."}),
        -- f({fn{6}})
      }),
  },
})
