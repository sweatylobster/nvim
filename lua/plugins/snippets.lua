return {
  'L3MON4D3/LuaSnip',
  config = function()
    local ls = require("luasnip")
    -- some shorthands...
    local snip = ls.snippet
    local node = ls.snippet_node
    local text = ls.text_node
    local insert = ls.insert_node
    local func = ls.function_node
    local choice = ls.choice_node
    local dynamicn = ls.dynamic_node

    -- for inodes
    local opts = { noremap = true, silent = true }
    vim.keymap.set("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
    vim.keymap.set("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
    vim.keymap.set("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
    vim.keymap.set("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

    -- define the function used by the snippet 
    local date = function() return {os.date('%Y-%m-%d')} end

    ls.add_snippets(nil, {
      all = {
	-- add date to document
	snip({
	  trig = "date",
	  namr = "Date",
	  dscr = "Date in the form of YYYY-MM-DD",
	  }, {
	    func(date, {}),
	}),
	snip({
	  trig = 'blank',
	  namr = 'blank',
	  dscr = 'fill something in with something',
	  }, {
	  text({})
	}),
	snip({
	  trig = "link",
	  namr = "markdown_link",
	  dscr = "Create markdown link [txt](url)"
	  },
	  {
	    text('['),
	    insert(1),
	    text(']('),
	    func(function(_, snip)
	      return snip.env.TM_SELECTED_TEXT[1] or {}
	    end, {}),
	    text(')'),
	    insert(0),
	}),
	snip({
	  trig = "meta",
	  namr = "Metadata",
	  dscr = "Yaml metadata format for markdown"
	  },
	  {
	    text({"---",
	      "title: "}), insert(1, "note_title"), text({"", 
	      "author: "}), insert(2, "author"), text({"", 
	      "date: "}), func(date, {}), text({"",
	      "categories: ["}), insert(3, ""), text({"]",
	      "lastmod: "}), func(date, {}), text({"",
	      "tags: ["}), insert(4), text({"]",
	      "comments: true",
	      "---", ""}),
	    insert(0)
	}),

	snip({
	  trig = "newsnip",
	  namr = "NewSnippet",
	  dscr = "Make a new snippet"
	  },
	  {
	    text({"snip({",
	      "  trig = \""}), insert(3, "trig"), text({"\",", 
	      "  namr = \""}), insert(2, "name"), text({"\",", 
	      "  dscr = \""}), insert(1, "desc"), text({"\",",
	      "  },",
	      "  {",
	      "    text({})",
	      "})", ""}),
	--snip({
	})
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
