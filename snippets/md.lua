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
      trig = "AB",
    },{
        t({"```mermaid",
        -- swap out with choice node
        "graph TD", ""}),
        t("A("), i(1, "NODE_A"), t(")"),
        t(" --> "),
        t("B("), i(0, "NODE_B"), t(")"),
        t({"", "```"}),
      }),
  }
})
