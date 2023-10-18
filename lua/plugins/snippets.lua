return {
  'L3MON4D3/LuaSnip',
  -- Try adding a range of python and other language snippets
  dependencies = {'rafamadriz/friendly-snippets'},
  config = function()
    local ls = require("luasnip")

    -- da guy in da beginners video linked in the LuaSnip repo
    ls.config.set_config({
      history = true,
      updateevents = "TextChanged, TextChangedI",
      enable_autosnippets = true,
      ext_opts = {},
    })

    -- move around in inodes
    local opts = { noremap = true, silent = true }
    vim.keymap.set("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
    vim.keymap.set("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
    vim.keymap.set("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
    vim.keymap.set("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

    -- set choicenode keybinds for both INSERT and VISUAL.
    vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
    vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
    vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-prev-choice", {})
    vim.api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-prev-choice", {})

  end
}

-- these were ext_opts!!!!!!
-- {
-- 	[require("luasnip.util.types").choiceNode] = {
-- 	  active = {
-- 	    virt_text = { { "haha", "Gruvbox Orange" } },
-- 	  },
-- 	},
--       }
