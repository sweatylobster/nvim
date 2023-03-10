return {
  'L3MON4D3/LuaSnip',
  config = function()
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

    -- for inodes
    local opts = { noremap = true, silent = true }
    vim.keymap.set("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
    vim.keymap.set("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
    vim.keymap.set("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
    vim.keymap.set("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

    -- define the function used by the snippet 
    local date = function() return {os.date('%Y-%m-%d')} end

    -- if male return "Mr." if female return "Ms."
    -- local monsieur = function(arg)
    --   if arg == "male" then return "Mr." end
    --   if arg == "female" then return "Ms." end
    -- end
    --
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
  end,
}
--
-- The patient is a {age}-year-old {RL}-hand dominant {sex} with {body_part} injuries sustained {DOI} in {possessive_gender_lowercase}.
-- function possessive_gender_lowercase()
-- end
--
--
-- snip({
--   trig = "bafl",
--   namr = "binomial distribution",
--   dscr = "does a quick binomial distribution in python",
--   },
--   {
--
--     text({})
-- })
--
-- snip({
--   trig = "newsnip",
--   namr = "NewSnippet",
--   dscr = "Make a new snippet"
--   },
--   {
--     text({"snip({",
--       "  trig = \""}), insert(3, "trig"), text({"\",",
--       "  namr = \""}), insert(2, "name"), text({"\",",
--       "  dscr = \""}), insert(1, "desc"), text({"\",",
--       "  },",
--       "  {",
--       "    text({})",
--       "})", ""}),
--
--
