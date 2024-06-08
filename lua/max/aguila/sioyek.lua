local M = {}

M.LIENS_FILE = '/Users/max/code/aguila/billing/liens/liens.csv'
M.SIOYEK_BINARY_PATH = "/Applications/sioyek.app/Contents/MacOS/sioyek"
M.SIOYEK_RUNNING = function ()
  local ps = vim.system({'ps'}):wait()
  local m = ps.stdout:match(M.SIOYEK_BINARY_PATH)
  if m then
    return true
  end
end
M.CHECK_IN_LIENS = function ()
  if vim.api.nvim_buf_get_name(0) ~= M.LIENS_FILE then
    print("Not the right file to run this in.")
    return false
  else
    return true
  end
end
M.READ_LINE = function()
  local line = vim.api.nvim_get_current_line()
  local path = os.getenv("SCANS").."/"..line:match("^%d+,([%d%-]+),")..".pdf"
  local page = line:match(",(%d+)$")
  return path, page
end
M.PAGER = false
M.LAST_PDF = {
  update = function(dos_pdf)
    print('updating: ', dos_pdf)
    assert(io.open('/tmp/last_pdf', "w+"):write(dos_pdf))
  end,
  read = function ()
    local s = assert(io.open('/tmp/last_pdf', 'r')):read()
    print('reading:', s)
    return s
  end
}

M.LOOKUP_PAGE = function ()
  coroutine.wrap(function ()
    M.CHECK_IN_LIENS()
    local dos_pdf, page = M.READ_LINE()
    if M.LAST_PDF.read() ~= dos_pdf then
      vim.system({'sioyek', '--execute-command', 'open_document', '--execute-command-data', dos_pdf,}, { stdout = false }):wait()
      M.LAST_PDF.update(dos_pdf)
    end
    vim.system({'sioyek', '--execute-command', 'goto_page_with_page_number', '--execute-command-data', page}, { stdout = false })
    -- maybe do something with M.DOS_PDF, like checking if we need to change the file
  end)()
end

vim.api.nvim_create_user_command("LookupPage", function (args)
  M.LOOKUP_PAGE()
end, {desc=""})

vim.api.nvim_create_user_command("PageNext", function ()
  coroutine.wrap(function ()
    vim.system({'sioyek', '--execute-command', 'next_page'}, { stdout = false })
  end)()
end, {desc="Go to the next page"})

vim.api.nvim_create_user_command("PagePrevious", function ()
  coroutine.wrap(function ()
    vim.system({'sioyek', '--execute-command', 'previous_page'}, { stdout = false })
  end)()
end, {desc="Go to the previous page"})

vim.api.nvim_create_user_command("PagerToggle", function ()
  coroutine.wrap(function ()
    assert(M.CHECK_IN_LIENS(), "Can't do that lol")
    M.PAGER = not M.PAGER
    if M.PAGER then
      -- TODO: figure out a way to hide this :/
      vim.api.nvim_buf_set_keymap(0, 'n', 'j', 'j<bar>:LookupPage<cr>', {})
      vim.api.nvim_buf_set_keymap(0, 'n', 'k', 'k<bar>:LookupPage<cr>', {})
    else
      vim.api.nvim_buf_del_keymap(0, 'n', 'j')
      vim.api.nvim_buf_del_keymap(0, 'n', 'k')
    end
  end)()
end, {desc="Easily page through records"})

vim.api.nvim_create_user_command("CheckLien", function (args)
  local a = args['args']
  M.CHECK_IN_LIENS()
  local dos_pdf, page = M.READ_LINE()
  -- can we skip this if it's redundant?
  if not M.SIOYEK_RUNNING() then
    vim.system({'sioyek'}, { stdout = false })
  end
  -- maybe do something with M.DOS_PDF, like checking if we need to change the file
  if M.LAST_PDF.read() ~= dos_pdf then
    vim.system({'sioyek', '--execute-command', 'open_document', '--execute-command-data', dos_pdf,}, { stdout = false }):wait()
    M.LAST_PDF.update(dos_pdf)
  end
  vim.system({'sioyek', '--execute-command', 'goto_page_with_page_number', '--execute-command-data', page}, { stdout = false })
end, {desc="Open record in `sioyek`"})

vim.keymap.set('n', '<leader>alc', ':CheckLien<cr>')
vim.keymap.set('n', '<leader>alpt', ':PagerToggle<cr>')

-- NOTE: drafts for reading output of async commands, etc
local example = [[42392 ttys003    0:03.33 /Applications/sioyek.app/Contents/MacOS/sioyek /users/max/library/mobile documents/com~apple~clouddocs/scans/2024-06-05.pdf --execute-command goto_page_with_page_number --execute-command-data 14]]

local function read_ps()
  -- really, get all of this back as a table from a function that parses ps
  local pid, tty, dig, bin, dir, file, args = example:match(
    "(%d+)%s+(%w+%d+)%s+([%d:%.]+)%s([%w+%.%/]+)%s([%/%~%/%d%-%w%s]+/)(%d+%-%d+%-%d+%.pdf)%s(.+)$")
  return {
    ['pid']= pid,
    ['tty']= tty,
    ['dig']= dig,
    ['bin']= bin,
    ['dir']= dir,
    ['file']= file,
    ['args']= args,
  }
end

local function handle_args(args)
  for opt, arg in args:gmatch("(--[%w%-]+)%s([%w+%_%d]+)") do
    print('opt', opt)
    print('arg', arg)
  end
end

-- handle_args(args)

-- local function on_exit(obj)
--   print(obj.code)
-- end

return M
