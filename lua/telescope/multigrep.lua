local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values

M = {}

local live_multigrep = function(opts)
  opts = opts or {}
  opts.splitter = opts.splitter or "  " -- TJ's default
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local pieces = vim.split(prompt, opts.splitter)
      local args = { "rg" }
      if pieces[1] then
        table.insert(args, "-e") -- look for the following expression!
        table.insert(args, pieces[1])
      end

      if pieces[2] then
        table.insert(args, "-g") -- look for the following expression!
        table.insert(args, pieces[2])
      end

      ---@diagnostic disable-next-line: deprecated
      return vim.tbl_flatten({
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
      })
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })

  -- make a picker!
  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = "Multi Grep",
      finder = finder,
      previewer = conf.grep_previewer(opts),
      sorter = require("telescope.sorters").empty(),
      -- should be able to throw in actions somewhere here....
      -- <c-q> telescope.actions.send_to_qflist()
    })
    :find()
end

M.setup = function() end

return M
